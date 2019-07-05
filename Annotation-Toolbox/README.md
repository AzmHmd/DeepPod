# Annotation-Toolbox:

This graphical user interface (GUI) is designed to assist with manual annotation of different parts of the inflorescence. 

- This GUI can be run in MATLAB.
- To open and use it do the following steps:

     1- In MATLAB, open `Plant AnnotationToolbox.m` file and push the `run` botton. 

     2- A window will be opened. 

     3- You can upload your plant images using the `Load image folder` botton.

     4- You can choose the part you want to annotate in the popup menue and do annotation by clicking on the target part.

     5- After finishing the annotation on the whole image, save your results and move to the next image in the selected folder.

- In this toolbox, the user selects the class type `(tip, base, body of the silique and stem)` and clicks on the respective parts on each input image. The annotated parts (**points clicked**) are saved as **defined locations** based on image coordinates. A sample annotated image illustrating the defined parts of the silique (tip, base, body and stem) is shown in the paper.


- In order to change codes in the GUI: 
     1- In MATLAB, command window, type: `guide`
     
     2- A window will open, from the 'Open Existing GUI', select the location of the GUI file (Plant AnnotationToolbox.fig).
     
     3- Then the tool box will be ready for you to edit or add code.

- In order to visualise your annotations on various parts of the image, run the `visualise_annotations_on_image.m` code and specify the location of your image. You will see that each selected part will be shown on the original image with different colours and markers. 


