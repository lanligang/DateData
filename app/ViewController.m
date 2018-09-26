//
//  ViewController.m
//  app
//
//  Created by ios2 on 2018/8/22.
//  Copyright © 2018年 ios2. All rights reserved.
//

#import "ViewController.h"
#import "LGCalendarManager.h"
#import "CalendarModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	CGFloat height = 120;
	CGFloat width = 120;
	CGFloat space = 5;
	CGFloat hSpace = 5;
	CGFloat left = 20;
	CGFloat top = 200;

	LGCalendarManager *manager = [[LGCalendarManager alloc]initWithStartDate:[[NSDate date]timeIntervalSince1970]];
    NSArray *array = 	[manager getCalendarDataSoruceWithLimitMonth:100 type:CalendarNextType];
	for (CalendarHeaderModel *obj in array) {

		NSLog(@" %lu   \n|%@",(unsigned long)obj.calendarItemArray.count,obj.calendarItemArray);
	}

	return;
	for (int i = 0; i<9; i++)
	{
		UIView *v = [UIView new];
		v.backgroundColor = [UIColor redColor];
		NSInteger colum =  i%3;
		NSInteger row = i/3;
		CGFloat x =left + colum*space+colum*width;
		CGFloat y =top + row*hSpace+row*height;
		v.frame = CGRectMake(x, y, width, height);
	   v.tag = colum;
		[self.view addSubview:v];
	   UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ontap:)];
	   [v addGestureRecognizer:tap];
	}
}
-(void)ontap:(UITapGestureRecognizer *)tap
{
	[self.view bringSubviewToFront:tap.view];
	
	[UIView beginAnimations:@"aa" context:(__bridge void * _Nullable)(tap.view)];
	[UIView setAnimationDuration:2];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	if (tap.view.tag==1) {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:tap.view cache:NO];
	}else{
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:tap.view cache:NO];
	}
	tap.view.transform = CGAffineTransformMakeScale(3.0f, 3.0f);
	tap.view.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2.0f, 280.0f);
	[UIView setAnimationDelegate:self];
	[UIView commitAnimations];
}
-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	if ([animationID isEqualToString:@"aa"]) {
		UIView *v = (__bridge UIView *)(context);
		[v removeFromSuperview];
	}
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
