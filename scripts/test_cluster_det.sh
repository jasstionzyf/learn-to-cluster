CUDA_VISIBLE_DEVICES=0 PYTHONPATH=. python dsgcn/main.py \
    --stage det \
    --phase test \
    --config dsgcn/configs/cfg_test_0.7_0.75.yaml \
    --load_from /data1/mlib_data/models/learn_to_cluster/pretrained_models/pretrained_gcn_d.pth.tar \
    --save_output
