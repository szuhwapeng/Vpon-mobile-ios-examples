//
//  VponDFPBannerViewController.m
//  VponDFPSampleObjC
//
//  Created by EricChien on 2017/6/12.
//  Copyright © 2017年 Soul. All rights reserved.
//

#import "VponDFPBannerViewController.h"

@import GoogleMobileAds;

@interface VponDFPBannerViewController () <GADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *requestButton;

@property (weak, nonatomic) IBOutlet UIView *loadBannerView;

@property (strong, nonatomic) DFPBannerView *dfpBannerView;

@end

@implementation VponDFPBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"DFP - Banner";
    [self requestButtonDidTouch:self.requestButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Method

- (IBAction)requestButtonDidTouch:(UIButton *)sender {
    
    sender.enabled = NO;
    
    if (self.dfpBannerView != nil) {
        [self.dfpBannerView removeFromSuperview];
    }
    
    GADRequest *request = [GADRequest request];
//    request.testDevices = @[kGADSimulatorID];
    
    self.dfpBannerView = [[DFPBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
    self.dfpBannerView.adUnitID = @"";
    self.dfpBannerView.delegate = self;
    self.dfpBannerView.rootViewController = self;
    [self.dfpBannerView loadRequest:request];
}

#pragma mark - GADBannerView Delegate

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    NSLog(@"Received banner ad successfully");
    [self.loadBannerView addSubview:bannerView];
    self.requestButton.enabled = YES;
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"Failed to receive banner with error: %@", [error localizedFailureReason]);
    self.requestButton.enabled = YES;
}

@end
