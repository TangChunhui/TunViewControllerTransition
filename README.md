# TunViewControllerTransition
a category to transition animation

[swift版本](https://github.com/TuYuWang/TNTransiton)

![image](https://github.com/TuYuWang/TunViewControllerTransition/blob/master/effect.gif)

#### Installation
TunViewControllerTransition is available on CocoaPods. Just add the following to your project Podfile:
> pod 'TunViewControllerTransition', '~> 0.0.4'

#### Usage
![image](https://github.com/TuYuWang/TunViewControllerTransition/blob/master/思维导图.png)

#### FromVC
~~~
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

 [self animateTransitionFromView:fromView toView:@"toViewKeyPath"];

~~~

#### ToVC

~~~
 [self animateInverseTransition];
~~~
