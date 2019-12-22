# DMQIR 
This repo contains some GUIs writen in Matlab. The GUI uses multiple images as queries. Images are from LAMDA dataset which are available at http://www.lamda.nju.edu.cn/data_MIMLimage.ashx?AspxAutoDetectCookieSupport=1. 


# 1
Generate hash codes of images by https://github.com/akbacak/DMLH2  repo.

# 2 
Convert hash codes from txt to mat format and locate the them in the ./lamdaDataset/hashCodes folder. Note that filenames.mat file contain image file names and targets.mat file contains image labels which are encodes as one hot. 

# 3
Just run any GUI, everything is straight forward after that. The GUI dmqRetrieval use any two LAMDA images as queries. 
1 Choose Lamda Dataset. 
2 Choose any hash code size.
3 Choose query images.
4 Choose distance metric, hamming distances or EMR (Efficient Manifold Ranking).
5 Choose Pareto front number.
6 Navigate on the current front by Image Number

# 4 
The GUI dmqRetrieval_3d do the same thing for 3 queries from LAMDA dataset. The GUI dmqRetrieval_final use two queries from LAMDA but performs reranking among retrieved images.

# 5 
You dont want to choose query images LAMDA but from anywehere like google?. Download any jpg formatted image and locate them in the ./Python folder. For two queries use dmqRetrieval_final_v2. But You should select image labels manually from GUI. If  you want query labels be predicted by GUI the use dmqRetrieval_final_v3. dmqRetrieval_final_v3_3d use any three jpg formatted
images as queries.

# All details about this repo will be given after our publication accepted.
