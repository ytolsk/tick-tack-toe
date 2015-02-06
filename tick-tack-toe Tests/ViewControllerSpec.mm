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
    });
    
    describe(@"displays an empty game board", ^{
        beforeEach(^{
            [controller.collectionView layoutIfNeeded];
        });
        
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
        it(@"should display an X on first tap", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
            [controller.collectionView.delegate collectionView:controller.collectionView
                                      didSelectItemAtIndexPath:indexPath];
            
            // arrays  always return objects of type id, can send any message compiler knows about to id, but can't use dot notation
            [controller.collectionView.visibleCells[0] label].text should equal(@"X");
        });
    });
});

SPEC_END
