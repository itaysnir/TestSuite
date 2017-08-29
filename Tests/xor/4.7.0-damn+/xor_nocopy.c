#include <linux/init.h>
#include <linux/ip.h>
#include <linux/netdevice.h>
#include <linux/netfilter.h>
#include <linux/netfilter_ipv4.h>

MODULE_LICENSE("GPL");
static int glimit __read_mostly;
static struct device dummy_dev __read_mostly __read_mostly;

static inline uint8_t xor_op(uint8_t *array, uint8_t initial, uint32_t size)
{
	while (size--) {
		initial ^= array[size];
	}
	return initial;
}

/*static inline*/ int skb_xor(const struct sk_buff *skb)
{
	struct sk_buff *frag_iter;
	int i;
	uint8_t xor = 0;
	u8 *vaddr;
	int size = skb_headlen(skb);

	if (unlikely(glimit < skb_pagelen(skb) )) {
		trace_printk("100]%d -> [%d]\n", glimit, skb_pagelen(skb));
		glimit = skb_pagelen(skb);
	}
	/* XOR header. */
	//skb_copy_from_linear_data_offset(skb, offset, to, copy);
	xor = xor_op(skb->data, 0, skb_headlen(skb));

	// XOR skb frags
	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
		skb_frag_t *f = &skb_shinfo(skb)->frags[i];

		if (likely(is_dma_cache_page(skb_frag_page(f)))) {
			struct page *oldpage = skb_frag_page(f);
			void *newptr = dma_cache_alloc(&dummy_dev, skb_frag_size(f) ,DMA_TO_DEVICE);//alloc_pages(GFP_ATOMIC|__GFP_COMP, 4);
			//f->page.p = newpage;

			if (unlikely(!newptr)) {
				panic("FAILED TO ALLOC!!!\n");
			}
			memcpy(newptr + f->page_offset,
				page_address(oldpage) + f->page_offset,
				skb_frag_size(f));
				//skb_frag_size(f));
			//__free_pages(newpage, 4);
			put_page(virt_to_page(newptr));
	//		{
	//		int ref = atomic_read(&skb_frag_page(f)->_refcount);
	//		if (ref != refcnt) {
	//			trace_printk("ref: %d -> %d [%d]\n", refcnt, ref, skb_frag_size(f));
	//			refcnt = ref;
	//		}}
		}

		vaddr = page_address(skb_frag_page(f));
		size +=  skb_frag_size(f);
		xor_op(vaddr + f->page_offset, xor, skb_frag_size(f));
	}

	skb_walk_frags(skb, frag_iter) {
		size += skb_xor(frag_iter);
	}

	return size;

}

static unsigned int xor_nocopy(void *priv,
			       struct sk_buff *skb,
			       const struct nf_hook_state *state)
{
	skb_xor(skb);

	return NF_ACCEPT;
}

static struct nf_hook_ops xor_ops[] = {
	{
	.hook		= xor_nocopy,
	.hooknum	= NF_INET_LOCAL_IN,
	.pf		= PF_INET,
	.priority	= NF_IP_PRI_FIRST,
	},
};

int __init xor_start(void)
{
	trace_printk("Hello Xor!\n");
	dummy_dev.no_iommu = true;
	register_iova_map(&dummy_dev);
	nf_register_hooks(xor_ops, ARRAY_SIZE(xor_ops));
	return 0;
}

void __exit xor_finish(void)
{
	nf_unregister_hooks(xor_ops, ARRAY_SIZE(xor_ops));
}

module_init(xor_start);
module_exit(xor_finish);
