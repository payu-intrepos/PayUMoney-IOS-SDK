//
//  UIImageView+CitrusGraphics.h
//  CitrusGraphics
//
//  Created by Rajvinder Singh on 11/9/17.
//  Copyright © 2017 CitrusPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitrusGraphics: NSObject

+ (void)clearCache;

+ (void)imagePrefetcherForCard;

+ (void)imagePrefetcherForBank;

@end

@interface UIImageView (CitrusGraphics)

/** Adds activity indicator on UIImageVIew (Indicator will only be shown on UIImageView when image is getting loaded).
 
 */
- (void)setSystemActivity;

/** Load an image with a resource.
 @param cardScheme cardScheme, whose image is to be loaded
 */
- (void)loadCitrusCardWithCardScheme:(NSString * _Nonnull)cardScheme;

/** Load an image with a large resource.
 @param cardScheme cardScheme, whose image is to be loaded
 */
- (void)loadCitrusLargeCardWithCardScheme:(NSString * _Nonnull)cardScheme;

/** Load an image with a resource.
 @param bankCID bankCID of the bank whose image is to be loaded
 */
- (void)loadCitrusBankWithBankCID:(NSString * _Nonnull)bankCID;

/** Load an image with a large resource.
 @param bankCID bankCID of the bank whose image is to be loaded
 */
- (void)loadCitrusLargeBankWithBankCID:(NSString * _Nonnull)bankCID;

/** Load an image with a resource.
 @param bankCode bank code of the bank whose image is to be loaded
 */
- (void)loadCitrusBankWithBankCode:(NSString * _Nonnull)bankCode;

/** Load an image with a large resource.
 @param bankCode bank code of the bank whose image is to be loaded
 */
- (void)loadCitrusLargeBankWithBankCode:(NSString * _Nonnull)bankCode;

/** Load an image with a resource.
 @param bankCode bank code of the wallet whose image is to be loaded
 */
- (void)loadWalletWithBankCode:(NSString * _Nonnull)bankCode;

/** Load an image with a large resource.
 @param bankCode bank code of the wallet whose image is to be loaded
 */
- (void)loadLargeWalletWithBankCode:(NSString * _Nonnull)bankCode;

/** Load an image with a resource.
 @param IFSCCode IFSCCode of the bank whose image is to be loaded
 */
- (void)loadCitrusBankWithIFSCCode:(NSString * _Nonnull)IFSCCode;

/** Load an image with a large resource.
 @param IFSCCode IFSCCode of the bank whose image is to be loaded
 */
- (void)loadCitrusLargeBankWithIFSCCode:(NSString * _Nonnull)IFSCCode;

/** Prefetch an image with a Citrus Branding resource.
 @param brandingID id of the brand to be loaded
 */
- (void)loadCitrusBrandingWithBrandingID:(NSString * _Nonnull)brandingID;

/** Prefetch an image with a Citrus LazyPay resource.
 @param assetID id of the asset to be loaded
 */
- (void)loadCitrusLazyPayWithAssetID:(NSString * _Nonnull)assetID;

@end

