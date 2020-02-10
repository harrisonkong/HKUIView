# <img src="./docs/logo256.jpg" width="40" height="40" alt="skyRoute66 logo" style="vertical-align:middle"> HKUIView #
![Swift](https://img.shields.io/static/v1?label=Swift&message=4.0%20or%20above&color=%23FF4400&style=plastic) ![iOS](https://img.shields.io/static/v1?label=iOS&&message=11.0%20or%20above&color=yellow&style=plastic) ![Cocoapods](https://img.shields.io/cocoapods/v/HKUIView?label=pod&color=brightgreen&style=plastic) ![Cocoapods](https://img.shields.io/cocoapods/l/HKUIView?color=blue&style=plastic) ![Category](https://img.shields.io/static/v1?label=category&message=User%20Interface&color=blueviolet&style=plastic) 
#### Harrison Kong's Enhanced UIView ####

<img src="./docs/HKUIView.png" alt="HKUIView screenshot">

<img src="./docs/cloudline.png" alt="---line---">

## VERSION HISTORY ##

1.0.0 - 2020/01/18 - Initial release

## MINIMUM REQUIREMENTS ##

**Swift** 4.0 or above

**iOS** 11.0 or above

<img src="./docs/cloudline.png" alt="---line---">

## WHAT IS IT? ##
`HKUIView` enhances the functionality of UIView by providing these additional features:

### Dynamic Corner Radius 
Allows you to dynamically calculate the corner radius base on one of the followings:

- the width of the label
- the height of the label
- the length of the shorter edge of the label (width or height)
- the length of the longer edge of the label (width or height)

- Or, it can also be set to a constant

This is useful for labels that change size (e.g. device rotation) or for catering to screen sizes of different devices (e.g., iPhone vs. iPad)

### Border Customization
It also let users customize the border width, color and alpha value.

<img src="./docs/cloudline.png" alt="---line---">

## HOW TO INSTALL IT ##

Use one of the following methods:

### 1. Using CocoaPod ###

The module is avabilable via CocoaPods Trunk. Below is an example podfile. If you already use a podfile for your project, all you have to do is add the line that specifies `HKUIView`. The other dependencies will also be automatically installed in the xcworkspace.

```
platform :ios, '11.0'

target 'MyTarget' do

  use_frameworks!

  pod 'HKUIView', '~> 1.0.0'
  # other pods for your project

end

# This post_install section fixes a bug in CocoaPod that does not allow
# IBDesignables to render in interface builder

post_install do |installer|
installer.pods_project.targets.each do |target|
    target.new_shell_script_build_phase.shell_script = "mkdir -p $PODS_CONFIGURATION_BUILD_DIR/#{target.name}"
        target.build_configurations.each do |config|
            config.build_settings['CONFIGURATION_BUILD_DIR'] = '$PODS_CONFIGURATION_BUILD_DIR'
            config.build_settings.delete('CODE_SIGNING_ALLOWED')
            config.build_settings.delete('CODE_SIGNING_REQUIRED')
        end
    end
end
```

#### ***** IMPORTANT!! ***** ####

If you are installing this as a CocoaPod, you **MUST** include this script at the end of your Podfile or the Inspectables won't work in Interface Builder. However, if you don't, it will still function as expected at runtime. There is no need to include this if you do are not using Interface Builder.

```
# This post_install section fixes a bug in CocoaPod that does not allow
# IBDesignables to render in interface builder

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.new_shell_script_build_phase.shell_script = "mkdir -p $PODS_CONFIGURATION_BUILD_DIR/#{target.name}"
        target.build_configurations.each do |config|
            config.build_settings['CONFIGURATION_BUILD_DIR'] = '$PODS_CONFIGURATION_BUILD_DIR'
            config.build_settings.delete('CODE_SIGNING_ALLOWED')
            config.build_settings.delete('CODE_SIGNING_REQUIRED')
        end
    end
end
```

Don't forget to import the module in your source code:

```
import HKUIView
```

### 2. BY INCLUDING THE SOURCE FILES ###

You can also simply include the following source files in your project:

```
HKUIView.swift
UIView+HKAutoCornerRounding.swift
UIView+LengthCalculationBasis.swift
```

<img src="./docs/cloudline.png" alt="---line---">

## HOW TO USE IT ##

### Interface Builder ###

1. Drop a UIView in your view controller then change the class in the *Identity Inspector* pane to HKUIView like this:

<img src="./docs/Identity-Inspector.png" alt="identity inspector pane screenshot">

Note that you might need to wait for the design time code to compile after setting the class.

2. There will be 7 inspectable variables at the *Attribute Inspector* pane:

<img src="./docs/Attribute-Inspector.png" alt="attribute inspector pane screenshot">

  - the 1st one **Auto Corner Rounding** is an on/off switch to control whether automatic corner radius calculation will be enabled.
  - the 2nd attribute **Corner Rounding Basis** is an integer that corresponds to the following:

        1 = width of the label
        2 = height of the label
        3 = shorter edge (width or height) of the label
        4 = longer edge (width of height) of the label
        5 = no calculation, set to a constant
        
        If this is set to any number less than 1, it will be assumed to be 1
        If this is set to any number greater than 5, it will be assumed to be 5
  - the 3rd atrribute is **Corner Radius Constant** which is a CGFloat. This is only used if the previous attribute is 5 (constant).
  - the 4th attribute is **Corner Radius Factor** which is a CGFloat that is used to divide the chosen length in the 2nd attribute to be set as the font size. For example, if this is set to 24 and the previous attribute is 2 = height, the font size will be set to the height of the label divided by 24. Experiment to get the desired result. This attribute is not used if the 2nd attribute is set to 5 (constant).
  
  - The 5th, 6th and 7th attributes are **Border Color**, **Border Alpha**, and **Border Width**. Which are self explanatory.
  
In this example the result is shown in the first figure on this page. A red border that is 5 pixels thick.
  
3. Of course, the immediate appearance of the label might differ from the one at runtime if the label size changes.

### Programmatically ###

Create an instance of the class and then set the attributes (see Interface Builder above for explanations of the attributes)

```
let myView = HKUIView()

myView.autoCornerRounding = true
myView.roundingBasis = .height
myView.cornerRadiusConstant = 0.0  // not used here, only used if roundingBasis is .constant
myView.cornerRadiusFactor = 24.0

myView.borderColor = UIColor.red
myView.borderAlpha = 1.0
myView.borderWidth = 5.0
```

Note that the second attribute `roundingBasis` is an enumeration type that is declared in `UIView+LengthCalculationBasis.swift` as follow:

```
@objc public enum LengthCalculationBasis: Int {
   case width = 1
   case height
   case shorterEdge
   case longerEdge
   case constant
}
```

<img src="./docs/cloudline.png" alt="---line---">

## KNOWN ISSUES ##

There are no known issues currently.

