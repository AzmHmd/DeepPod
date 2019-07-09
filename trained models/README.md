
**Important files in model (`densenet`, `lenet`) repositories:


- train_val.txt: Model architecture used for the training phase
- deploy.txt: Model architecture used for the testing phase
- solver.prototxt: Containing optimisation approach and the respective hyper-parameters
- snapshotXXX.caffemodel: snapshot of the model at the end of different epoch during training, in protocol buffer format. The available caffemodel file stores the trained parameters, which can be used to classify image patches (of size 32x32) into different plant parts together with the model architecture file (deploy.txt) within CAFFE. 
-----------------------------------------------------------------------------------------------------
**Important files in the `training and validation sets` repository:

- train_db folder: lmdb format of the training set
- val_db folder: lmdb format of the validation set
- labels.txt: containing 4 classification groups (tip, base, stem, body)
- mean.jpg: mean image of the all images used in the training set
- mean.binaryproto: mean file of the all images used in the training set
- train.txt: list of the training samples
- val.txt: list of the validation samples

