#import <Cedar-iOS/Cedar-iOS.h>
#import "ViewController.h"
#import "CollectionViewCell.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ViewControllerSpec)

describe(@"ViewController", ^{
    __block ViewController *controller; // _block flag needed so we can assign value to controller in a block
    
    beforeEach(^{
        controller = [[ViewController alloc] init];
        [controller view];  // this calls through to viewDidLoad (but only once, which is more realistic)
        
        [controller.collectionView layoutIfNeeded];
    });
    
    describe(@"displays an empty game board", ^{
        it(@"should have a collectionView with all empty cells", ^{
            for (CollectionViewCell *cell in controller.collectionView.visibleCells) {
                [cell empty] should equal(YES);
            }
        });
        
        it(@"should have nine cells", ^{
            [controller.collectionView.visibleCells count] should equal(9);
        });
    });
    
    describe(@"should allow putting down Xs and Os", ^{
        void(^tapCellAndCheckContent)(NSInteger, NSString *) = ^(NSInteger index, NSString *content) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
            [controller.collectionView.delegate collectionView:controller.collectionView
                                      didSelectItemAtIndexPath:indexPath];
            [(CollectionViewCell *)[controller.collectionView cellForItemAtIndexPath:indexPath] label].text should equal(content);
        };
        
        it(@"should display an X on first tap", ^{
            tapCellAndCheckContent(0, @"X");
        });
        
        it(@"should display an O after an X", ^{
            tapCellAndCheckContent(0, @"X");

            tapCellAndCheckContent(1, @"O");
        });
        
        it(@"should not override the X with an O", ^{
            tapCellAndCheckContent(0, @"X");
            
            tapCellAndCheckContent(0, @"X");
        });
    });
});

SPEC_END
