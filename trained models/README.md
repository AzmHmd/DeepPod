
**Important files in model (`densenet`, `lenet`) repositories:


- train_val.txt: Model architecture used for the training phase
- deploy.txt: Model architecture used for the testing phase
- solver.prototxt: Containing optimisation approach and the respwctive hyper-parameters
- snapshotXXX.caffemodel: snapshot of the learning process during different epochs
-----------------------------------------------------------------------------------------------------
**Important files in the `training and validation sets` repository:

- train_db folder: lmdb format of the training set
- val_db folder: lmdb format of the validation set
- labels.txt: containing 4 classification gruos (tip, base, stem, body)
- mean.jpg: mean image of the all images used in the training set
- mean.binaryproto: mean file of the all images used in the training set
- train.txt: list of the training samples
- val.txt: list of the validation samples

