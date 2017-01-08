//
//  ViewController.m
//  mapgrounds
//
//  Created by Daniel Pape on 04/01/2014.
//  Copyright (c) 2014 Daniel Pape. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController : UITextfieldScrollViewController

#define METERS_PER_MILE 1609.344
#define kTutorialPointProductID @"com.danielpape.mapgrounds.colours"
#define   IS_IPHONE_5     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define   IS_IPAD     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )1024 ) < DBL_EPSILON )


BOOL colourMenuShowing;
BOOL searchBubbleShowing;
BOOL shareViewShowing;
BOOL purchased;
SKProductsRequest *productsRequest;
NSArray *validProducts;

- (void)viewDidLoad{
    [super viewDidLoad];
    
    if (IS_IPAD) {
        NSLog(@"is ipad");
    }
    NSLog(@"%f",self.view.bounds.size.height);
    //[self setTransparentBackgroundOnView:self.colourMenuView];
    
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 37.7833;
    zoomLocation.longitude= -122.4167;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 12*METERS_PER_MILE, 12*METERS_PER_MILE);
    
    // 3
    [self.map1 setRegion:viewRegion animated:YES];
    [self setRoundedCorners:self.saveView toDiameter:20];
    [self setRoundedCorners:self.introView toDiameter:20];
    [self setRoundedCorners:self.shareView toDiameter:20];
    [self setRoundedCorners:self.purchaseView toDiameter:20];
	searchBubbleShowing = YES;
    shareViewShowing = NO;
    
    self.changeLocationButton.enabled = NO;
    self.changeBackgroundButton.enabled = NO;
    self.saveButton.enabled = NO;
    self.shareButton.enabled = NO;
    
    self.map1.showsUserLocation = NO;
    
    [self fetchAvailableProducts];
    
    if (IS_IPAD) {
        [self setRoundedMapView:self.map1 toDiameter:500];
    }
    
    defaults = [[NSUserDefaults alloc]init];
    if([defaults boolForKey:@"purchasedDefaults"] == YES){
        purchased = YES;
        [self removeButtonImages];
    }
    [defaults synchronize];

    purchased = YES;
    NSLog(@"%f",self.map1.bounds.size.width);
    [self setRoundedMapView:self.map1 toDiameter:self.map1.bounds.size.width];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setRoundedMapView:(MKMapView *)roundedView toDiameter:(float)newSize;
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
}

-(void)setRoundedView:(UIView *)roundedView toDiameter:(float)newSize;
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
}

-(void)setRoundedCorners:(UIView *)roundedView toDiameter:(float)newSize;
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize;
    roundedView.center = saveCenter;
}

- (IBAction)tapYellowButton {
    if(purchased) {
    [self changeBackgroundColour:[UIColor colorWithRed:237/255.0f green:223/255.0f blue:173/255.0f alpha:1.0f]];
        self.caption.textColor = [UIColor blackColor];
    [self resetColourViewCenter];
    }else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [self.purchaseView setCenter:self.view.center];
        [UIView commitAnimations];
    }
}

- (IBAction)tapBlueButton {
    if(purchased) {
    [self changeBackgroundColour:[UIColor colorWithRed:126/255.0f green:199/255.0f blue:227/255.0f alpha:1.0f]];
        self.caption.textColor = [UIColor whiteColor];
    [self resetColourViewCenter];
    }else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [self.purchaseView setCenter:self.view.center];
        [UIView commitAnimations];
    }
}

- (IBAction)tapPinkButton {
    if(purchased) {
    [self changeBackgroundColour:[UIColor colorWithRed:210/255.0f green:0/255.0f blue:35/255.0f alpha:1.0f]];
        self.caption.textColor = [UIColor whiteColor];
    [self resetColourViewCenter];
    }else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [self.purchaseView setCenter:self.view.center];
        [UIView commitAnimations];
    }
}

- (IBAction)tapGreenButton {
    if(purchased) {
    [self changeBackgroundColour:[UIColor colorWithRed:119/255.0f green:193/255.0f blue:183/255.0f alpha:1.0f]];
        self.caption.textColor = [UIColor whiteColor];
    [self resetColourViewCenter];
    }else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [self.purchaseView setCenter:self.view.center];
        [UIView commitAnimations];
    }
}

- (IBAction)tapWhiteButton {
    if(purchased) {
    [self changeBackgroundColour:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f]];
        self.caption.textColor = [UIColor darkGrayColor];
    [self resetColourViewCenter];
    }else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [self.purchaseView setCenter:self.view.center];
        [UIView commitAnimations];
    }

}

- (void)changeBackgroundColour:(UIColor*)withcolour{
    self.view.backgroundColor = withcolour;
    colourMenuShowing = NO;
}

- (IBAction)tapEditText:(id)sender {
    [sender becomeFirstResponder];
    CGPoint viewCenter = CGPointMake(self.view.center.x, (self.view.center.y-210));
    self.changeLocationButton.enabled = NO;
    self.changeBackgroundButton.enabled = NO;
    self.saveButton.enabled = NO;
    self.shareButton.enabled = NO;
    self.introView.alpha = 0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.15];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [self.view setCenter:viewCenter];
    [UIView commitAnimations];
}

- (IBAction)tapLocationButton{
    if(searchBubbleShowing == NO) {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.searchBar.placeholder = @"Enter a special place";
    self.searchBubbleView.alpha = 1;
    [UIView commitAnimations];
        searchBubbleShowing = YES;
    }else if (searchBubbleShowing == YES){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.searchBubbleView.alpha = 0;
        [UIView commitAnimations];
        searchBubbleShowing = NO;
    }
}

- (IBAction)returnKeyPressed:(id)sender{
    [sender resignFirstResponder];
    self.changeLocationButton.enabled = YES;
    self.changeBackgroundButton.enabled = YES;
    self.saveButton.enabled = YES;
    self.shareButton.enabled = YES;
    CGPoint viewCenter = CGPointMake(self.view.center.x, (self.view.center.y+210));
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.15];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [self.view setCenter:viewCenter];
    [UIView commitAnimations];
}

- (IBAction)tapBackgroundbutton {
    if(colourMenuShowing == NO){
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    CGPoint colourViewCenter = [self.colourMenuView center];
    colourViewCenter.x = self.view.bounds.size.width/2;
    colourViewCenter.y = 30;
    [self.colourMenuView setCenter:colourViewCenter];
    [UIView commitAnimations];
    colourMenuShowing = YES;
    }else if(colourMenuShowing == YES){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        CGPoint colourViewCenter = [self.colourMenuView center];
        colourViewCenter.x = self.view.bounds.size.width/2;
        colourViewCenter.y = -60;
        [self.colourMenuView setCenter:colourViewCenter];
        [UIView commitAnimations];
        colourMenuShowing = NO;
    }
}

- (void)resetColourViewCenter{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    CGPoint colourViewCenter = [self.colourMenuView center];
    colourViewCenter.x = self.view.bounds.size.width/2;
    colourViewCenter.y = -40;
    [self.colourMenuView setCenter:colourViewCenter];
    [UIView commitAnimations];
}

-(void)setupCoordsUsingAddress:(NSString *)address {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if(error) {
            
            NSLog(@"FAILED to obtain geocodeAddress String. Error : %@", error);
            searchBubbleShowing = YES;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            self.searchBubbleView.alpha = 1;
            self.searchBar.placeholder = @"Sorry, please try another";
            self.searchBar.text = @"";
            [UIView commitAnimations];
            //abort();
            
            
        } else if(placemarks && placemarks.count > 0) {
            
            // Find all retail stores...
            [self issueLocalSearchLookup:@"retail" usingPlacemarksArray:placemarks];
        }
    }];
}

// Ex: [self issueLocalSearchLookup:@"grocery"];
-(void)issueLocalSearchLookup:(NSString *)searchString usingPlacemarksArray:(NSArray *)placemarks {
    
    // Search 0.250km from point for stores.
    CLPlacemark *placemark = placemarks[0];
    CLLocation *location = placemark.location;
    
    self.coords = location.coordinate;
    
    // Set the size (local/span) of the region (address, w/e) we want to get search results for.
    MKCoordinateSpan span = MKCoordinateSpanMake(0.6250, 0.6250);
    MKCoordinateRegion region = MKCoordinateRegionMake(self.coords, span);
    
    [self.map1 setRegion:region animated:NO];
    
    // Create the search request
    self.localSearchRequest = [[MKLocalSearchRequest alloc] init];
    self.localSearchRequest.region = region;
    self.localSearchRequest.naturalLanguageQuery = searchString;
    
    // Perform the search request...
    self.localSearch = [[MKLocalSearch alloc] initWithRequest:self.localSearchRequest];
    [self.localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
        if(error){
            
            NSLog(@"localSearch startWithCompletionHandlerFailed!  Error: %@", error);
            return;
            
        } else {
            
            // We are here because we have data!  Yay..  a whole 10 records of it too *flex*
            // Do whatever with it here...
            
            for(MKMapItem *mapItem in response.mapItems){
                
                // Show pins, pix, w/e...
                
                NSLog(@"Name for result: = %@", mapItem.name);
                // Other properties includes: phoneNumber, placemark, url, etc.
                // More info here: https://developer.apple.com/library/ios/#documentation/MapKit/Reference/MKLocalSearch/Reference/Reference.html#//apple_ref/doc/uid/TP40012893
            }
            
            MKCoordinateSpan span = MKCoordinateSpanMake(0.2, 0.2);
            MKCoordinateRegion region = MKCoordinateRegionMake(self.coords, span);
            [self.map1 setRegion:region animated:NO];
        }
    }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"%@",self.searchBar.text);
    [self setupCoordsUsingAddress:[NSString stringWithFormat:@"%@",self.searchBar.text]];
    [self.searchBar resignFirstResponder];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.searchBubbleView.alpha = 0;
    //self.introView.alpha = 0;
    [UIView commitAnimations];
    searchBubbleShowing = NO;
}

-(IBAction)saveScreen{
    self.saveButton.alpha = 0;
    self.changeBackgroundButton.alpha = 0;
    self.changeLocationButton.alpha=0;
    self.shareButton.alpha = 0;
    self.searchBubbleView.alpha=0;
    [self.shareView setCenter:CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height+self.shareView.bounds.size.height)];
    [self.colourMenuView setCenter:CGPointMake(self.view.bounds.size.width/2, -40)];
        if ([self.caption.text  isEqual: @""]) {
        self.caption.alpha = 0;
    }
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0.0);
    
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    self.saveButton.alpha = 1;
    self.changeBackgroundButton.alpha = 1;
    self.changeLocationButton.alpha=1;
    self.caption.alpha = 1;
    self.shareButton.alpha = 1;
    if(searchBubbleShowing){
    self.searchBubbleView.alpha = 1;
    }
    [self presentSaveScreen];
    
}

- (void)presentSaveScreen{
    [self.saveView setCenter:CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height+self.saveView.bounds.size.height)];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [self.saveView setCenter:self.view.center];
    [UIView commitAnimations];
}

- (IBAction)tweetButtonPressed:(id)sender{
    self.saveButton.alpha = 0;
    self.changeBackgroundButton.alpha = 0;
    self.changeLocationButton.alpha=0;
    self.shareButton.alpha = 0;
    self.searchBubbleView.alpha = 0;
    shareViewShowing = NO;
    [self.shareView setCenter:self.view.center];
    if ([self.caption.text  isEqual: @""]) {
        self.caption.alpha = 0;
    }
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.saveButton.alpha = 1;
    self.changeBackgroundButton.alpha = 1;
    self.changeLocationButton.alpha=1;
    self.caption.alpha = 1;
    self.shareButton.alpha = 1;
    if(searchBubbleShowing){
        self.searchBubbleView.alpha = 1;
    }
    //1
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        //2
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        //3
        if(IS_IPAD) {
        [tweetSheet setInitialText:@"Check out the iPad wallpaper I made with @mapgrounds. Create your own here:bit.ly/196xQem"]; [tweetSheet addImage:image];
        }else{
            [tweetSheet setInitialText:@"Check out the iPhone wallpaper I made with @mapgrounds. Create your own here:bit.ly/196xQem"]; [tweetSheet addImage:image];
        }
        //4
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"please setup Twitter" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)facebookButtonPressed:(id)sender{
    self.saveButton.alpha = 0;
    self.changeBackgroundButton.alpha = 0;
    self.changeLocationButton.alpha=0;
    self.shareButton.alpha = 0;
    self.searchBubbleView.alpha = 0;
    shareViewShowing = NO;
    [self.shareView setCenter:CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height+self.shareView.bounds.size.height)];
    if ([self.caption.text  isEqual: @""]) {
        self.caption.alpha = 0;
    }
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.saveButton.alpha = 1;
    self.changeBackgroundButton.alpha = 1;
    self.changeLocationButton.alpha=1;
    self.caption.alpha = 1;
    self.shareButton.alpha = 1;
    if(searchBubbleShowing){
        self.searchBubbleView.alpha = 1;
    }
    //1
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        //2
        SLComposeViewController *faceSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        //3
        
        if(IS_IPAD) {
            [faceSheet setInitialText:@"Check out the iPad wallpaper I made with Mapgrounds. Create your own here: http://bit.ly/196xQem"]; [faceSheet addImage:image];
        }else{
            [faceSheet setInitialText:@"Check out the iPhone wallpaper I made with Mapgrounds. Create your own here: http://bit.ly/196xQem"]; [faceSheet addImage:image];
        }
        //4
        [self presentViewController:faceSheet animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please setup Facebook" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }

}

- (IBAction)tapGotItButton {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [self.saveView setCenter:CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height+self.saveView.bounds.size.height)];
    [UIView commitAnimations];
}

- (IBAction)tapBeginButton {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [self.introView setCenter:CGPointMake(self.view.frame.size.width/2, -1000)];
    self.searchBubbleView.alpha = 1;
    [UIView commitAnimations];
    
    if (IS_IPAD) {
        [self setRoundedMapView:self.map1 toDiameter:500];
        [self.map1 setFrame:CGRectMake(135, 262, 500, 500)];
        [self.searchBubbleView setCenter:CGPointMake(self.view.frame.size.width/2, self.map1.center.y-277)];
        [self.caption setCenter:CGPointMake(384, 800)];
;

    }
    self.changeLocationButton.enabled = YES;
    self.changeBackgroundButton.enabled = YES;
    self.saveButton.enabled = YES;
    self.shareButton.enabled = YES;
    self.caption.alpha = 1;
    }

- (IBAction)tapShareButton {
    if (shareViewShowing) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.8];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [self.shareView setCenter:CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height+self.shareView.bounds.size.height)];
        [UIView commitAnimations];
        shareViewShowing = NO;
    }else if(shareViewShowing == NO){
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [self.shareView setCenter:self.view.center];
    [UIView commitAnimations];
    shareViewShowing = YES;
    }
}

/////

-(void)fetchAvailableProducts{
    NSSet *productIdentifiers = [NSSet
                                 setWithObjects:kTutorialPointProductID,nil];
    productsRequest = [[SKProductsRequest alloc]
                       initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
}

- (BOOL)canMakePurchases
{
    return [SKPaymentQueue canMakePayments];
}
- (void)purchaseMyProduct:(SKProduct*)product{
    if ([self canMakePurchases]) {
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"Purchases are disabled in your device" message:nil delegate:
                                  self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
    }
}
-(IBAction)purchase:(id)sender{
    [self purchaseMyProduct:[validProducts objectAtIndex:0]];
    //self.purchaseButton.enabled = NO;
}

#pragma mark StoreKit Delegate

-(void)paymentQueue:(SKPaymentQueue *)queue
updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                self.activityIndicator.alpha = 1;
                [self.activityIndicator startAnimating];
                NSLog(@"Purchasing");
                break;
            case SKPaymentTransactionStatePurchased:
                if ([transaction.payment.productIdentifier
                     isEqualToString:kTutorialPointProductID]) {
                    NSLog(@"Purchased ");
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                              @"Purchase is completed succesfully" message:nil delegate:
                                              self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    [alertView show];
                    self.activityIndicator.alpha = 0;
                    [self.activityIndicator startAnimating];
                    [UIView beginAnimations:nil context:NULL];
                    [UIView setAnimationDuration:0.5];
                    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                    [self.purchaseView setCenter:CGPointMake(160, 1000)];
                    [UIView commitAnimations];
                    [self removeButtonImages];
                    purchased = YES;
                    defaults = [[NSUserDefaults alloc]init];
                    [defaults setBool:YES forKey:@"purchasedDefaults"];
                    [defaults synchronize];
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                self.activityIndicator.alpha = 0;
                [self.activityIndicator startAnimating];
                NSLog(@"Restored ");
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.5];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [self.purchaseView setCenter:CGPointMake(160, 1000)];
                [UIView commitAnimations];
                [self removeButtonImages];
                purchased = YES;
                defaults = [[NSUserDefaults alloc]init];
                [defaults setBool:YES forKey:@"purchasedDefaults"];
                [defaults synchronize];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                self.activityIndicator.alpha = 0;
                [self.activityIndicator startAnimating];
                NSLog(@"Purchase failed ");
                break;
            default:
                break;
        }
    }
}

-(void)productsRequest:(SKProductsRequest *)request
    didReceiveResponse:(SKProductsResponse *)response
{
    SKProduct *validProduct = nil;
    int count = [response.products count];
    if (count>0) {
        validProducts = response.products;
        validProduct = [response.products objectAtIndex:0];
        if ([validProduct.productIdentifier
             isEqualToString:kTutorialPointProductID]) {
            [self.productTitleLabel setText:[NSString stringWithFormat:
                                        @"Product Title: %@",validProduct.localizedTitle]];
            self.productPriceLabel.text = [NSString stringWithFormat:@"Buy now for just %@",validProduct.priceAsString];
             [UIView commitAnimations];
        }
    } else {
        UIAlertView *tmp = [[UIAlertView alloc]
                            initWithTitle:@"Not Available"
                            message:@"No products to purchase"
                            delegate:self
                            cancelButtonTitle:nil
                            otherButtonTitles:@"Ok", nil];
        [tmp show];
    }    
    [self.activityIndicator stopAnimating];
    self.purchaseButton.hidden = NO;
}

- (IBAction)tapNoThanksButton{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [self.purchaseView setCenter:CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height+self.purchaseView.bounds.size.height)];
    self.purchaseButton.titleLabel.text = @"Purchase";
    [UIView commitAnimations];
}

- (void)removeButtonImages{
    [self.yellowButton setImage:Nil forState:UIControlStateNormal];
    [self.pinkButton setImage:Nil forState:UIControlStateNormal];
    [self.blueButton setImage:Nil forState:UIControlStateNormal];
    [self.greenButton setImage:Nil forState:UIControlStateNormal];
}

- (IBAction)restoreCompletedTransactions:(id)sender{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

-(void)setTransparentBackgroundOnView:(UIView*)onview{
    onview.backgroundColor = [UIColor whiteColor];
    bgToolbar = [[UIToolbar alloc] initWithFrame:onview.frame];
    bgToolbar.barStyle = UIBarStyleBlackTranslucent;
    [onview.superview insertSubview:bgToolbar belowSubview:onview];
}

- (IBAction)makeScreenSmaller{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    CGRect smallScreenSize =  CGRectMake(190, 0, 320, 568);
    [self.view setFrame:smallScreenSize];
    [UIView commitAnimations];
}

@end
