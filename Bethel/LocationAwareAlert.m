//
//  LocationAwareAlert.m
//  
//
//  Created by Albert Martin on 4/13/14.
//
//

#import "AppDelegate.h"
#import "LocationAwareAlert.h"

@implementation LocationAwareAlert

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    FBShimmeringView *welcomeTitleView = [[FBShimmeringView alloc] init];
    welcomeTitleView.shimmering = YES;
    welcomeTitleView.shimmeringBeginFadeDuration = 0.3;
    welcomeTitleView.shimmeringOpacity = 0.6;
    welcomeTitleView.shimmeringSpeed = 110;
    welcomeTitleView.frame = CGRectMake(12, 8, 290, 20);
    [self.view addSubview:welcomeTitleView];
    
    _welcomeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 290, 0)];
    _welcomeTitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    _welcomeTitleLabel.textColor = [UIColor whiteColor];
    welcomeTitleView.contentView = _welcomeTitleLabel;
    
    CALayer *disclosure = [CALayer layer];
    disclosure.frame = CGRectMake(self.view.bounds.size.width-30, 7, 23, 23);
    disclosure.contents = (id)[UIImage imageNamed:@"DisclosureOpen"].CGImage;
    disclosure.opacity = 0.7;
    [self.view.layer addSublayer:disclosure];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)showLocationAlert
{
    _welcomeTitleLabel.text = [NSString stringWithFormat:@"Welcome to %@", [(AppDelegate *)[[UIApplication sharedApplication] delegate] liveLocation].title];
    CGRect alertFrame = self.view.frame;
    alertFrame.origin.y = self.view.superview.frame.size.height-36;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = alertFrame;
    }];
    
    _isLocationAlertVisible = TRUE;
}

- (void)hideLocationAlert
{
    CGRect alertFrame = self.view.frame;
    alertFrame.origin.y = self.view.superview.frame.size.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = alertFrame;
    }];
    
    _isLocationAlertVisible = FALSE;
}

- (void)handleTapGesture:(id)sender
{
    [self hideLocationAlert];
    
    [[[UIApplication sharedApplication] delegate].window.rootViewController performSegueWithIdentifier:@"ShowSplash" sender:self];
}

@end
