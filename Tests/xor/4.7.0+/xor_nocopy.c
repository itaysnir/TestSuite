#include <linux/init.h>
#include <linux/ip.h>
#include <linux/netdevice.h>
#include <linux/netfilter.h>
#include <linux/netfilter_ipv4.h>

MODULE_LICENSE("GPL");

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
	int size = skb_headlen(skb);

	/* XOR header. */
	//skb_copy_from_linear_data_offset(skb, offset, to, copy);
	xor = xor_op(skb->data, 0, skb_headlen(skb));

	// XOR skb frags
	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
		skb_frag_t *f = &skb_shinfo(skb)->frags[i];

		u8 *vaddr = page_address(skb_frag_page(f));
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
	int size = skb_xor(skb);

	if (unlikely(size != skb->len))
		trace_printk("skb %p: len %d : [%d]\n",
			      skb, skb->len, size);
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
	nf_register_hooks(xor_ops, ARRAY_SIZE(xor_ops));
	return 0;
}

void __exit xor_finish(void)
{
	nf_unregister_hooks(xor_ops, ARRAY_SIZE(xor_ops));
}

module_init(xor_start);
module_exit(xor_finish);
