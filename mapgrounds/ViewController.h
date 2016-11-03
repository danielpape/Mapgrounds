//
//  ViewController.h
//  mapgrounds
//
//  Created by Daniel Pape on 04/01/2014.
//  Copyright (c) 2014 Daniel Pape. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "UITextfieldScrollViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Social/Social.h>
#import <StoreKit/StoreKit.h>
#import "SKProduct+priceAsString.h"

@interface ViewController : UITextfieldScrollViewController<
SKProductsRequestDelegate,SKPaymentTransactionObserver>{
    NSUserDefaults *defaults;
    UIToolbar *bgToolbar;
}

@property (weak, nonatomic) IBOutlet MKMapView *map1;
@property (weak, nonatomic) IBOutlet UIView *colourMenuView;
@property CLLocationCoordinate2D coords;
@property (nonatomic, strong) MKLocalSearch *localSearch;
@property (nonatomic, strong) MKLocalSearchRequest *localSearchRequest;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *changeBackgroundButton;
@property (weak, nonatomic) IBOutlet UIButton *changeLocationButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIView *searchBubbleView;
@property (weak, nonatomic) IBOutlet UITextField *caption;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIView *saveView;
@property (weak, nonatomic) IBOutlet UIView *introView;
@property (weak, nonatomic) IBOutlet UIView *shareView;
@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *productDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *productPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *purchaseButton;
@property (weak, nonatomic) IBOutlet UIView *purchaseView;
@property (weak, nonatomic) IBOutlet UIButton *yellowButton;
@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@property (weak, nonatomic) IBOutlet UIButton *greenButton;
@property (weak, nonatomic) IBOutlet UIButton *whiteButton;
@property (weak, nonatomic) IBOutlet UIButton *pinkButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


- (IBAction)tapYellowButton;
- (IBAction)tapBlueButton;
- (IBAction)tapPinkButton;
- (IBAction)tapGreenButton;
- (IBAction)tapWhiteButton;
- (IBAction)tapEditText:(id)sender;
- (IBAction)tapLocationButton;
- (IBAction)saveScreen;
- (IBAction)tweetButtonPressed:(id)sender;
- (IBAction)facebookButtonPressed:(id)sender;
- (IBAction)tapGotItButton;
- (IBAction)tapBeginButton;
- (IBAction)tapShareButton;
- (IBAction)tapNoThanksButton;
- (IBAction)makeScreenSmaller;

- (IBAction)returnKeyPressed:(id)sender;
- (IBAction)tapBackgroundbutton;
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
- (IBAction)restoreCompletedTransactions:(id)sender;

@end
