#!/usr/bin/env bash
prefix=/data1/mlib_data/features/vcg_clustering/
name=vcg_test
oprefix=$prefix/cluster_proposals

dim=512
knn=80
method=faiss
th=0.75
step=0.05
minsz=2
maxsz=300
metric=pairwise

# generate proposals
PYTHONPATH=. /usr/local/miniconda3/bin/python proposals/generate_proposals.py \
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
    --is_save_proposals

# evaluate
PYTHONPATH=. /usr/local/miniconda3/bin/python evaluation/evaluate.py \
    --metric $metric \
    --gt_labels $prefix/labels/$name.meta \
    --pred_labels $oprefix/$name/$method\_k_$knn\_th_$th\_step_$step\_minsz_$minsz\_maxsz_$maxsz\_iter_0/pred_labels.txt
