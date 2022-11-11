#ifndef TCF_WRAPPER
#define TCF_WRAPPER

#include <cuda.h>
#include <cuda_runtime_api.h>

#include <cooperative_groups.h>

#include <poggers/metadata.cuh>
#include <poggers/hash_schemes/murmurhash.cuh>
#include <poggers/probing_schemes/linear_probing.cuh>
#include <poggers/probing_schemes/double_hashing.cuh>
#include <poggers/insert_schemes/power_of_n_shortcut.cuh>
#include <poggers/insert_schemes/single_slot_insert.cuh>
#include <poggers/insert_schemes/bucket_insert.cuh>
#include <poggers/insert_schemes/power_of_n.cuh>
#include <poggers/representations/key_val_pair.cuh>
#include <poggers/representations/shortened_key_val_pair.cuh>


#include <poggers/representations/dynamic_container.cuh>
#include <poggers/representations/key_only.cuh>

#include <poggers/sizing/default_sizing.cuh>
#include <poggers/sizing/variadic_sizing.cuh>
#include <poggers/tables/base_table.cuh>


namespace cg = cooperative_groups;

using tiny_static_table_4 = poggers::tables::static_table<uint64_t, uint16_t, poggers::representations::shortened_key_val_wrapper<uint16_t>::key_val_pair, 4, 4, poggers::insert_schemes::bucket_insert, 20, poggers::probing_schemes::doubleHasher, poggers::hashers::murmurHasher>;
using tcf = poggers::tables::static_table<uint64_t,uint16_t, poggers::representations::shortened_key_val_wrapper<uint16_t>::key_val_pair, 4, 16, poggers::insert_schemes::power_of_n_insert_shortcut_scheme, 2, poggers::probing_schemes::doubleHasher, poggers::hashers::murmurHasher, true, tiny_static_table_4>;



struct tcf_wrapper{

	tcf * my_filter;

	//instaniate filter to hold ~2^num_bits items
	void init(num_bits){


		poggers::sizing::variadic_size test_size (1ULL << num_bits, (1ULL << num_bits)/100);
		my_filter = tcf::generate_on_device(&test_size, 73);

	}

	//clean up and free GPU memory
	void close(){

		tcf::free_on_device(my_filter);

	}

	bool insert(cg::thread_block_tile<4> tile,  uint64_t key, uint16_t val){

		return filter->insert(tile, key, val);

	}




	bool query(cg::thread_block_tile<4> tile, uint64_t key, uint16_t & val){

		return filter->query(tile, key, val);

	}


	bool remove(cg::thread_block_tile<4> tile, uint64_t key){

		return filter->remove(tile, key);

	}




}


#endif //TCF_WRAPPER