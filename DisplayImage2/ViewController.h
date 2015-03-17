//
//  ViewController.h
//  DisplayImage2
//
//  Created by Francisco Surroca on 10/20/13.
//  Copyright (c) 2013 Francisco Surroca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UIImageView *imageView;
    IBOutlet UIImageView *tempImageView;
    
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    
    BOOL mouseSwiped;
}

-(IBAction)showImage;

@end
