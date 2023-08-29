import cv2
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

def plot_points_of_lines(lines):
    for line in lines:
        plt.plot(line[0], line[1], 'ro')
        plt.plot(line[2], line[3], 'ro',color='green')
    plt.show()


def getLines(image_path='t'):
    img = cv2.imread(image_path+'.png')
    # Converter para escala de cinza
    img_gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    img_gray = cv2.GaussianBlur(img_gray, (5,5),cv2.BORDER_DEFAULT)

    #Create default parametrization LSD
    lsd = cv2.createLineSegmentDetector(100)

    #Detect lines in the image
    lines = lsd.detect(img_gray)[0] #Position 0 of the returned tuple are the detected lines

    lines = lines.reshape((-1,4))

    vectors = np.zeros([lines.shape[0],2])

    vectors[:,0] = lines[:,2] - lines[:,0]

    vectors[:,1] = lines[:,1] - lines[:,3]

    norm = np.linalg.norm(vectors, axis=1)

    lines = np.concatenate([lines,np.array([norm]).T],axis=1)

    median = np.median(norm)

    idx = np.where(norm > median)[0]

    lines_fil = lines[idx,:]

    return lines_fil


print(getLines()[:10,:])

# read image from file with matplotlib

# img_ori = plt.imread(image_path+'-color.png')

#plt.imshow(img_ori)

# plotar imagem e os pontos por cima

#drawn_img = lsd.drawSegments(img_ori,lines_fil)

# plt.imshow(drawn_img)

# plot_points_of_lines(lines_fil)