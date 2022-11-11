#ifndef B_BLOOM_WRAPPER
#define B_BLOOM_WRAPPER



#include <warpcore/bloom_filter.cuh>


using warpcore_bloom = warpcore::BloomFilter<uint64_t>;

struct warpcore_bloom_wrapper {

	tcf * internal_tcf;

	void init(num_bits);

	void shutdown();


	__device__ void insert(cg::partitioned_tile<4> my_tile)


}



#endif //B_BLOOM_WRAPPER