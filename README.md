# new_toast

A new Flutter project.
![imgpsh_fullsize_anim (1)](https://github.com/user-attachments/assets/67617df7-151a-4e5e-b204-ca545aca639d)
![image](https://github.com/user-attachments/assets/841c7b3a-8e61-43a8-b278-5899ba4e2d71)


Custom Toast Package for Flutter
Overview:
This custom toast package provides a simple yet flexible solution for showing toast messages in Flutter applications. It supports the following features:

Positioning the toast at the top, left, or right of the screen.
Optional image support to display alongside the toast message.
Customizable toast duration, background color, shadow color, and text style.
An optional animation that smoothly slides the toast in from the specified position.
Key Features:
Flexible Positioning: The toast message can appear at the top, left, or right of the screen, with smooth entry animations. For the top position, the toast slides down from above the screen and stays centered horizontally.

Image Support: Optionally, you can include an image with each toast, and the size of the image can be adjusted by setting custom image width and height. If no image is provided, the layout automatically adjusts to exclude the image space.

Custom Styling: You can fully customize the appearance of the toast, including:

Background Color: Choose the background color for the toast.
Shadow Color: Optionally add shadows with customizable color.
Text Style: Customize the font style of the message text to suit your app's theme.
Animations: The package supports a smooth sliding animation using Flutter's SlideTransition. For top-positioned toasts, the message slides down from above the screen and appears centered. For left and right positions, it slides horizontally from the side.

Easy Integration: Developers can easily invoke the toast using a static method CustomToast.show(), passing in the required message and optional parameters like image, duration, colors, etc.

Toast Animation:
The toast appears with a sliding effect. If positioned at the top, the toast slides down from off-screen. If positioned on the left or right, it slides in horizontally. The animation is smooth and responsive, providing a visually appealing user experience.

Key Considerations:
Centering: When the toast is shown at the top, it automatically centers itself horizontally, ensuring that it’s positioned perfectly in the middle of the screen.
Responsiveness: The width of the toast container is constrained based on the screen width, ensuring that the message is readable on all device sizes.
Error-Free Image Handling: The toast automatically adjusts if no image is provided, and developers can set default or custom sizes for the image if needed.
