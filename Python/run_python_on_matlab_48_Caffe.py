#coding=utf-8

import numpy as np
import sys,os
import matplotlib
matplotlib.use('Agg')
import caffe
import time
import cv2

#MODEL = "./Caffemodels/bvlc_reference_caffenet.caffemodel"
MODEL = "/home/ubuntu/caffe/models/ssdh48_lamda_v3/Snapshots/ssdh48_lamda_iter_5000.caffemodel"
PROTO = "/home/ubuntu/caffe/models/ssdh48_lamda_v3/deploy.prototxt"
MEAN = "/home/ubuntu/caffe/data/lamda/mean.npy"


class binaryCodesGenerator(object):

  def __init__(self, modelDir):
    self.model = os.path.join(modelDir, MODEL)
    self.proto = os.path.join(modelDir, PROTO)
    self.mean = os.path.join(modelDir, MEAN)
    self.initcaffe()

  def initcaffe(self):
    caffe.set_mode_cpu()
    self.net = caffe.Net(self.proto, self.model, caffe.TEST)
    self.net.forward()
    self.transformer = caffe.io.Transformer({'data': self.net.blobs['data'].data.shape})
    self.transformer.set_transpose('data', (2,0,1))
    self.transformer.set_mean('data', np.load(self.mean).mean(1).mean(1))
    self.transformer.set_raw_scale('data', 255)
    self.transformer.set_channel_swap('data', (2,1,0))

  def hashing(self, image):
    array = np.fromstring(image, dtype='uint8')
    im = cv2.imdecode(array,1)
    im = im / 255.
    im = im[:,:,(2,1,0)]
    self.net.blobs['data'].data[...] = self.transformer.preprocess('data', im)
    self.net.forward()
    # obtain the output probabilities
    feat = self.net.blobs['latent_sigmoid'].data[0]
    # generate binary codes
    binary_codes = feat > 0.5
    binary_codes = binary_codes.astype(int)
    return binary_codes



if __name__ == "__main__":
    bCG = binaryCodesGenerator('/home/ubuntu/caffe/models/')             
    # img1
    img_1 = 'Python/q1.jpg'
    with open(img_1,'rb') as infile:
      buf = infile.read()
    binary_codes_1 = bCG.hashing(buf)
    
    
    # img2
    img_2 = 'Python/q2.jpg'
    with open(img_2,'rb') as infile:
      buf = infile.read()
    binary_codes_2 = bCG.hashing(buf)
    
     # img3
    img_3 = 'Python/q3.jpg'
    with open(img_3,'rb') as infile:
      buf = infile.read()
    binary_codes_3 = bCG.hashing(buf)
  




np.savetxt('Python/q1.txt', binary_codes_1,  fmt='%d',  delimiter=',')
np.savetxt('Python/q2.txt', binary_codes_2,  fmt='%d',  delimiter=',')
np.savetxt('Python/q3.txt', binary_codes_3,  fmt='%d',  delimiter=',')

