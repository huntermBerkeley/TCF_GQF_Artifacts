#ifndef BLOOM_WRAPPER
#define BLOOM_WRAPPER

#include <cuda.h>
#include <cuda_runtime_api.h>

#include <cooperative_groups.h>


#include "bloom_filter.hpp"


namespace cg = cooperative_groups;

using tiny_static_table_4 = poggers::tables::static_table<uint64_t, uint16_t, poggers::representations::shortened_key_val_wrapper<uint16_t>::key_val_pair, 4, 4, poggers::insert_schemes::bucket_insert, 20, poggers::probing_schemes::doubleHasher, poggers::hashers::murmurHasher>;
using tcf = poggers::tables::static_table<uint64_t,uint16_t, poggers::representations::shortened_key_val_wrapper<uint16_t>::key_val_pair, 4, 16, poggers::insert_schemes::power_of_n_insert_shortcut_scheme, 2, poggers::probing_schemes::doubleHasher, poggers::hashers::murmurHasher, true, tiny_static_table_4>;


struct tcf_wrapper {

	tcf * internal_tcf;

	void init(num_bits);

	void shutdown();


	__device__ void insert(cg::partitioned_tile<4> my_tile)


}



#endif //TCF_WRAPPER