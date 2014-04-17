//
//  CPViewController.m
//  CPImageTest
//
//  Created by Hiromichi Yamada on 2014/04/15.
//  Copyright (c) 2014年 Hiromichi Yamada. All rights reserved.
//

#import "CPViewController.h"
#import "UIImage+ImageEffects.h"

@interface CPViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@end

@implementation CPViewController
{
    UIImage*    imageOrg;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    imageOrg    = [UIImage imageNamed:@"testImage0.jpg"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTestPressed:(id)sender
{
    if( imageOrg == nil ){
        NSLog(@"no data..");
        return;
    }
    self.imageView1.image   = nil;
    self.imageView2.image   = nil;
    
    // 10回測定してみる.
    for ( int i=0; i<10; i++) {
        NSLog(@"check [%d]", i);
        
        @autoreleasepool {
            NSDate *startDate = [NSDate date];
            [self performSelectorOnMainThread:@selector(doTest1) withObject:nil waitUntilDone:YES];
            NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:startDate];
            NSLog(@"test1 -- %lf", interval);
        }
        
        @autoreleasepool {
            NSDate *startDate = [NSDate date];
            [self performSelectorOnMainThread:@selector(doTest2) withObject:nil waitUntilDone:YES];
            NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:startDate];
            NSLog(@"test2 -- %lf", interval);
        }
        
    }
}


#pragma mark - tests

- (void) doTest1
{
    CGFloat     radius      = 15.0f;
    UIColor     *tintColor      = [UIColor colorWithWhite:0.21f alpha:0.5f];
    UIImage     *imageResult    = [imageOrg applyBlurWithRadius:radius tintColor:tintColor saturationDeltaFactor:1.f maskImage:nil];
    self.imageView1.image   = imageResult;
}

- (void) doTest2
{
    CGFloat     radius      = 15.0f;
    CIColor     *tintColor  = [CIColor colorWithRed:0.21 green:0.21 blue:0.21 alpha:0.5];
    UIImage     *imageResult    = [imageOrg applyFastBlurWithRadius:radius tintColor:tintColor];
    self.imageView2
    .image   = imageResult;
}

#pragma mark - image



@end

