#!/usr/bin/env bash
prefix=/data1/mlib_data/features/vcg_clustering/
name=vcg_test
oprefix=$prefix/cluster_proposals

dim=512
knn=80
method=faiss
th=0.8
step=0.05
minsz=4
maxsz=300
iter=1
metric=pairwise

gt_labels=$prefix/labels/$name.meta
sv_labels=/data1/mlib_data/features/vcg_clustering//cluster_proposals/vcg_test/faiss_k_2_th_0.4_step_0.05_minsz_4_maxsz_500_minsz_2_maxsz_16_iter_1/pred_labels.txt
sv_knn_prefix=$prefix/knns/$name/

# generate proposals iteratively
knn=2
th=0.4
sv_minsz=2
sv_maxsz=16
maxsz=500
iter=$(($iter+1))

# generate iterative proposals
PYTHONPATH=. python proposals/generate_iter_proposals.py \
    --prefix $prefix \
    --oprefix $oprefix \
    --name $name \
    --dim $dim \
    --knn $knn \
    --knn_method $method \
    --th_knn $th \
    --th_step $step \
    --min_size $minsz \
    --max_size $maxsz \
    --sv_min_size $sv_minsz \
    --sv_max_size $sv_maxsz \
    --sv_labels $sv_labels \
    --sv_knn_prefix $sv_knn_prefix \
    --is_save_proposals
PYTHONPATH=. /usr/local/miniconda3/bin/python evaluation/evaluate.py \
    --metric $metric \
    --gt_labels $prefix/labels/$name.meta \
    --pred_labels /data1/mlib_data/features/vcg_clustering//cluster_proposals/vcg_test/faiss_k_2_th_0.4_step_0.05_minsz_4_maxsz_500_sv_minsz_2_maxsz_16_iter_1/pred_labels.txt
