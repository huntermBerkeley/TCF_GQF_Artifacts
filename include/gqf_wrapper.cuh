#ifndef GQF_WRAPPER
#define GQF_WRAPPER

#include <cuda.h>
#include <cuda_runtime_api.h>

#include <cooperative_groups.h>


#include "gqf.cuh"

struct tcf_wrapper {

	tcf * internal_tcf;

	void init(num_bits);

	void shutdown();


	__device__ void insert(cg::partitioned_tile<4> my_tile)


}



#endif //TCF_WRAPPER