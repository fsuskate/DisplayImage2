//
//  ViewController.m
//  DisplayImage2
//
//  Created by Francisco Surroca on 10/20/13.
//  Copyright (c) 2013 Francisco Surroca. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(IBAction)showImage
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController*)UIPicker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *pickedImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    if (pickedImg != nil)
    {
        // Draw something on it
        //UIGraphicsBeginImageContext(pickedImg.size);
        
        // Draw original image
        //[pickedImg drawAtPoint:CGPointZero];
        
        // Get context for CoreGraphics
        //CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        // Set stroke color
        //[[UIColor redColor] setStroke];
        //[[UIColor blueColor] setFill];
        
        //CGRect circRect = CGRectMake(0, 0, pickedImg.size.width/2, pickedImg.size.height/2);
        //circRect = CGRectInset(circRect, 5, 5);
        
        // Draw
        //CGContextStrokeEllipseInRect(ctx, circRect);
        //CGContextFillEllipseInRect(ctx, circRect);
        
        // Make image out of bitmap context
        //UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // Free the Context
        //UIGraphicsEndImageContext();
        //[imageView setImage:retImage];
        
        [imageView setImage:pickedImg];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Handle touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.view];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self->tempImageView.image drawInRect:CGRectMake(0,0, self.view.frame.size.width,  self.view.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self->tempImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    [self->tempImageView setAlpha:opacity];
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!mouseSwiped)
    {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self->tempImageView.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self->tempImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    else
    {
        UIGraphicsBeginImageContext(self->imageView.frame.size);
        [self->imageView.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
        [self->tempImageView.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
        self->imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        self->tempImageView.image = nil;
        UIGraphicsEndImageContext();
    }
}


- (void)viewDidLoad
{
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 10.0;
    opacity = 1.0;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
