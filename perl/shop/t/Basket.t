use strict;
use Test::More;
use Data::Dumper;
use WebServiceClient;
use WebServiceConfiguration
  qw( WEBSERVICE_URL WEBSERVICE_USER WEBSERVICE_SHOP_PATH);
use WebServiceTools qw( TAttributes hAttributes cmpDateTime );

# Create a SOAP::Lite client object
my $BasketService =
  WebServiceClient->uri('urn://epages.de/WebService/BasketService/2013/11')
  ->proxy(WEBSERVICE_URL)->userinfo(WEBSERVICE_USER)->xmlschema('2001');

# use product service to get GUIDs by given object paths of demo products
my $ProductService =
  WebServiceClient->uri('urn://epages.de/WebService/ProductService/2013/01')
  ->proxy(WEBSERVICE_URL)->userinfo(WEBSERVICE_USER)->xmlschema('2001');

my $product_alias_1 = "prdouctalias1";
my $product_alias_2 = "prdouctalias2";
my $product_alias_3 = "prdouctalias3";

# create test products
my $Product_in_1 = {

    'Alias'      => $product_alias_1,
    'StockLevel' => 17,
    'ProductPrices' =>
      [ { 'CurrencyID' => 'EUR', 'Price' => 123, 'TaxModel' => 'gross', }, ],
    'IsAvailable' => SOAP::Data->type('boolean')->value(1)
};

my $Product_in_2 = {

    'Alias'      => $product_alias_2,
    'StockLevel' => 17,
    'ProductPrices' =>
      [ { 'CurrencyID' => 'EUR', 'Price' => 123, 'TaxModel' => 'gross', }, ],
    'IsAvailable' => SOAP::Data->type('boolean')->value(1)
};

my $Product_in_3 = {

    'Alias'      => $product_alias_3,
    'StockLevel' => 17,
    'ProductPrices' =>
      [ { 'CurrencyID' => 'EUR', 'Price' => 123, 'TaxModel' => 'gross', }, ],
    'IsAvailable' => SOAP::Data->type('boolean')->value(1)
};

my %GUID;

sub main {
    init();
    test();
    done_testing();
}

sub init() {
    cleanup();
    create_products( [ $Product_in_1, $Product_in_2, $Product_in_3 ] );
    fetch_product_guids();
}

sub test {
#
#    #create basket1 with 1 product
#    my $basket1 = {
#        'LineItemContainer' => {
#            'CurrencyID'       => 'EUR',
#            'TaxArea'          => '/TaxMatrixGermany/EU',
#            'TaxModel'         => 'gross',
#            'ProductLineItems' => [
#                {
#                    'Product'   => $GUID{$product_alias_1},
#                    'Quantity'  => '10',
#                    'OrderUnit' => '/Units/piece'
#                },
#            ],
#        },
#    };
#
#    #create basket2 with 2 products
#    my $basket2 = {
#        'LineItemContainer' => {
#            'CurrencyID'       => 'EUR',
#            'TaxArea'          => '/TaxMatrixGermany/EU',
#            'TaxModel'         => 'gross',
#            'ProductLineItems' => [
#                {
#                    'Product'   => $GUID{$product_alias_1},
#                    'Quantity'  => '2',
#                    'OrderUnit' => '/Units/piece'
#                },
#                {
#                    'Product'   => $GUID{$product_alias_2},
#                    'Quantity'  => '3',
#                    'OrderUnit' => '/Units/piece'
#                },
#            ],
#        },
#    };
#
#    my $basket1Path = testCreateBasket($basket1);
#
#    #exists basket1?
#    testExistsByPath( $basket1Path, 1 );
#
#    #check info of basket1
#    testGetInfoReference( $basket1Path, $basket1 );
#
#    #delete basket?
#    testDeleteBasket($basket1Path);
#
#    #dont exists basket1?
#    testExistsByPath( $basket1Path, 0 );
#
#    my $basket2Path = testCreateBasket($basket2);
#
#    #exists basket2?
#    testExistsByPath( $basket2Path, 1 );
#
#    #check info of basket2
#    testGetInfoReference( $basket2Path, $basket2 );
#
#    #update quantity of one product in basket2
#    my $QuantityBefore0 =
#      $basket2->{'LineItemContainer'}->{'ProductLineItems'}->[0]->{'Quantity'};
#    $basket2->{'LineItemContainer'}->{'ProductLineItems'}->[0]->{'Quantity'} =
#      7;
#    my $QuantityBefore1 =
#      $basket2->{'LineItemContainer'}->{'ProductLineItems'}->[1]->{'Quantity'};
#    $basket2->{'LineItemContainer'}->{'ProductLineItems'}->[1]->{'Quantity'} =
#      1;
#    testUpdateBasket( $basket2Path, $basket2 );
#
#    #check info of basket2
#    $basket2->{'LineItemContainer'}->{'ProductLineItems'}->[0]->{'Quantity'} +=
#      $QuantityBefore0;
#    $basket2->{'LineItemContainer'}->{'ProductLineItems'}->[1]->{'Quantity'} +=
#      $QuantityBefore1;
#    testGetInfoReference( $basket2Path, $basket2 );
#
#    #add 3rd product to basket2
#    testUpdateBasket(
#        $basket2Path,
#        {
#            'LineItemContainer' => {
#                'CurrencyID'       => 'EUR',
#                'TaxArea'          => '/TaxMatrixGermany/EU',
#                'TaxModel'         => 'gross',
#                'ProductLineItems' => [
#                    { 'Product' => $GUID{$product_alias_3}, 'Quantity' => '1' },
#                ],
#            },
#        }
#    );
#
#    my $basket3 = {
#        'BillingAddress' => {
#            'EMail'     => 'mmustermann@epages.de',
#            'FirstName' => 'Max',
#            'LastName'  => 'Mustermann',
#            'Street'    => 'Musterstrasse 2',
#            'Street2'   => 'Ortsteil Niederfingeln',
#            'CodePorte' => '13a',
#        },
#        'LineItemContainer' => {
#            'CurrencyID'       => 'EUR',
#            'TaxArea'          => '/TaxMatrixGermany/EU',
#            'TaxModel'         => 'gross',
#            'ProductLineItems' => [
#                {
#                    'Product'   => $GUID{$product_alias_1},
#                    'Quantity'  => '2',
#                    'OrderUnit' => '/Units/piece'
#                },
#                {
#                    'Product'   => $GUID{$product_alias_2},
#                    'Quantity'  => '3',
#                    'OrderUnit' => '/Units/piece'
#                },
#            ],
#        },
#    };
#
#    #check info of basket2
#    push @{ $basket2->{LineItemContainer}->{ProductLineItems} },
#      {
#        'Product'   => $GUID{$product_alias_3},
#        'Quantity'  => '1',
#        'OrderUnit' => '/Units/piece'
#      };
#    my $hBasket = testGetInfoReference( $basket2Path, $basket2 );
#
#    #change first line item product to basket2
#    my $hContainer      = $hBasket->{LineItemContainer};
#    my $hLineItem       = $hContainer->{'ProductLineItems'}->[0];
#    my $changedProduct  = $hLineItem->{Product};
#    my $changedQuantity = 17;
#    my $LineItem        = {
#        Alias       => $hLineItem->{Alias},
#        Quantity    => $changedQuantity,
#        'OrderUnit' => '/Units/piece'
#    };
#    testUpdateLineItem( $basket2Path, $LineItem, $basket2 );
#
#    #check info of basket2
#    foreach $LineItem (
#        @{ $basket2->{'LineItemContainer'}->{'ProductLineItems'} } )
#    {
#        $LineItem->{'Quantity'} = $changedQuantity
#          if $LineItem->{Product} eq $changedProduct;
#    }
#    $hBasket = testGetInfoReference( $basket2Path, $basket2 );
#
#    #remove last changed line item
#    testDeleteLineItem( $basket2Path, $hLineItem->{Alias} );
#
#    #check info of basket2
#    my @Items = grep { $_ if $_->{Product} ne $changedProduct }
#      @{ $basket2->{'LineItemContainer'}->{'ProductLineItems'} };
#    $basket2->{'LineItemContainer'}->{'ProductLineItems'} = \@Items;
#    $hBasket = testGetInfoReference( $basket2Path, $basket2 );
#
#    #put this prodcut back to basket
#    $LineItem = {
#        'GUID'      => $changedProduct,
#        'Quantity'  => $changedQuantity,
#        'OrderUnit' => '/Units/piece'
#    };
#    testAddProductLineItem( $basket2Path, $LineItem, $basket2 );
#
#    #check info of basket2
#    push @{ $basket2->{LineItemContainer}->{ProductLineItems} },
#      {
#        'Product'   => $changedProduct,
#        'Quantity'  => $changedQuantity,
#        'OrderUnit' => '/Units/piece'
#      };
#    testGetInfoReference( $basket2Path, $basket2 );
#
#    #delete basket2
#    testDeleteBasket($basket2Path);
#
#    #dont exists basket2?
#    testExistsByPath( $basket2Path, 0 );
#
#    #create basket3 with 2 products and address data
#
#    my $basket3Path = testCreateBasket($basket3);
#
#    #chek if exist
#    testExistsByPath( $basket3Path, 1 );
#
#    #check result of creation
#    $hBasket = testGetInfoReference( $basket3Path, $basket3 );
#
#    #delete basket3
#    testDeleteBasket($basket3Path);
#
#    #dont exists basket3?
#    testExistsByPath( $basket3Path, 0 );
    testCreateBasket();
    testExistsBasket();
}

sub fetch_product_guids {

    # array of product paths that involved in basket tests
    my @ProductPaths = map "Products/$_",
      ( $product_alias_1, $product_alias_2, $product_alias_3 );
    my $prodInfoResult =
      $ProductService->getInfo( \@ProductPaths, ['GUID'] )->result;
    ok( !$prodInfoResult->[0]->{'Error'},
        "'fetch_product_guids: getInfo product GUIDs" );

    # store GUID for easy acces via $GUID{$Alias}
    %GUID =
      map { $_->{Alias} => $_->{Attributes}->[0]->{Value} } @$prodInfoResult;
}

sub create_products {
    my ($aProducts) = @_;

    $ProductService->create($aProducts)->result;
}

sub cleanup {
    deleteProductsIfExists(
        [ $product_alias_1, $product_alias_2, $product_alias_3 ] );
}

sub deleteProductsIfExists {
    my ($aProductAliases) = @_;

    foreach my $Alias (@$aProductAliases) {
        my $ahResults =
          $ProductService->exists( [ '/Shops/DemoShop/Products/' . $Alias ] )
          ->result;

        next unless $ahResults->[0]->{'exists'};

        $ProductService->delete( [ '/Shops/DemoShop/Products/' . $Alias ] );
    }

    return;
}

sub testExistsByPath {
    my ( $Path, $exists ) = @_;

    my $ahResults = $BasketService->exists( [$Path] )->result;
    is( scalar @$ahResults, 1, 'exists: result count' );

    my $hExists = $ahResults->[0];
    ok( !$hExists->{'Error'}, 'exists: no error' );
    diag $hExists->{'Error'}->{'Message'} . "\n" if $hExists->{'Error'};

    ok( $hExists->{'Path'} eq $Path, 'exists: basket path' );
    is( $hExists->{'exists'}, $exists, 'exists?' );
}

# Create a Basket and check if the creation was successful
sub testCreateBasket_old {
    my ($Basket) = @_;

    #note("PAVEL !!!!!!");
    my $ahResults = $BasketService->create( [$Basket] )->result;
    is( scalar @$ahResults, 1, 'create: result count' );

    #note("\n========================\n:" . Dumper($ahResults));
    my $hCreate = $ahResults->[0];

    #note("\n========================\n:" . Dumper($hCreate));
    ok( !$hCreate->{'Error'}, 'create: no error' );

    is( $hCreate->{'created'}, 1, 'created?' );

    return $hCreate->{'Path'};
}

sub testGetInfoReference_old {
    my ( $basketPath, $basketRef ) = @_;

    my $ahResults = $BasketService->getInfo( [$basketPath], [], [] )->result;
    is( scalar @$ahResults, 1, 'getInfo result set' );

    my $hInfo = $ahResults->[0];
    ok( !$hInfo->{'Error'}, 'getInfo: no error' );
    diag "Error: $hInfo->{'Error'}\n" if $hInfo->{'Error'};

    my $hLineItemContainer  = $hInfo->{'LineItemContainer'};
    my $hLineItemContainer2 = $basketRef->{'LineItemContainer'};
    ok( $hLineItemContainer->{'TaxArea'} eq $hLineItemContainer2->{'TaxArea'},
        'tax area' );
    ok(
        $hLineItemContainer->{'TaxModel'} eq $hLineItemContainer2->{'TaxModel'},
        'tax model'
    );
    ok(
        $hLineItemContainer->{'CurrencyID'} eq
          $hLineItemContainer2->{'CurrencyID'},
        'currencyid'
    );

    ok(
        $hLineItemContainer->{'ProductLineItems'},
        'list of all product line items'
    );
    my @ProductLineItems =
      map {
        {
            $_->{'Product'},
              {
                'Quantity'  => $_->{'Quantity'},
                'OrderUnit' => $_->{'OrderUnit'}
              }
        }
      } sort { $a->{Product} le $b->{Product} }
      @{ $hLineItemContainer->{'ProductLineItems'} };
    my @ProductLineItemsRef =
      map {
        {
            $_->{'Product'},
              {
                'Quantity'  => $_->{'Quantity'},
                'OrderUnit' => $_->{'OrderUnit'}
              }
        }
      } sort { $a->{Product} le $b->{Product} }
      @{ $hLineItemContainer2->{'ProductLineItems'} };

    is_deeply( \@ProductLineItems, \@ProductLineItemsRef,
        'product line items' );

    return $hInfo;
}

sub testDeleteBasket_old {
    my ($basketPath) = @_;

    my $ahResults = $BasketService->delete( [$basketPath] )->result;
    is( scalar @$ahResults, 1, 'delete: result count' );

    my $hDelete = $ahResults->[0];
    ok( !$hDelete->{'Error'}, 'delete: no error' );
    diag $hDelete->{'Error'}->{'Message'} . "\n" if $hDelete->{'Error'};

    ok( $hDelete->{'Path'} eq $basketPath, 'delete: order path' );
    is( $hDelete->{'deleted'}, 1, 'deleted?' );
}

sub testUpdateBasket_old {
    my ( $Path, $Basket ) = @_;
    $Basket->{Path} = $Path;

    my $ahResults = $BasketService->update( [$Basket] )->result;
    is( scalar @$ahResults, 1, 'update: result count' );

    my $hUpdate = $ahResults->[0];
    ok( !$hUpdate->{'Error'}, 'update: no error' );
    diag $hUpdate->{'Error'}->{'Message'} . "\n" if $hUpdate->{'Error'};

    ok( $hUpdate->{'Path'} eq $Path, 'path path' );
    is( $hUpdate->{'updated'}, 1, 'updated?' );

}

sub testAddProductLineItem_old {
    my ( $Path, $LineItem, $Basket ) = @_;
    $Basket->{Path} = $Path;

    my $ahResults =
      $BasketService->addProductLineItem( $Path, [$LineItem] )->result;
    is( scalar @$ahResults, 1, 'add product: result count' );

    my $hUpdate = $ahResults->[0];
    ok( !$hUpdate->{'Error'}, 'add product: no error' );
    diag $hUpdate->{'Error'}->{'Message'} . "\n" if $hUpdate->{'Error'};

    ok( $hUpdate->{'GUID'} eq $LineItem->{GUID}, 'product GUID' );
    is( $hUpdate->{'added'}, 1, 'added?' );
}

sub testUpdateLineItem_old {
    my ( $Path, $LineItem, $Basket ) = @_;
    $Basket->{Path} = $Path;

    my $ahResults =
      $BasketService->updateLineItem( $Path, [$LineItem] )->result;
    is( scalar @$ahResults, 1, 'update: result count' );

    my $hUpdate = $ahResults->[0];
    ok( !$hUpdate->{'Error'}, 'update: no error' );
    diag $hUpdate->{'Error'}->{'Message'} . "\n" if $hUpdate->{'Error'};

    my $LineItemPath = "$Path/LineItemContainer/$LineItem->{Alias}";
    ok( $hUpdate->{'Path'} eq $LineItemPath, 'line item path' );
    is( $hUpdate->{'updated'}, 1, 'updated?' );
}

sub testDeleteLineItem_old {
    my ( $Path, $LineItemAlias, $Basket ) = @_;
    $Basket->{Path} = $Path;

    my $ahResults =
      $BasketService->deleteLineItem( $Path, [$LineItemAlias] )->result;
    is( scalar @$ahResults, 1, 'delete: result count' );

    my $hDelete = $ahResults->[0];
    ok( !$hDelete->{'Error'}, 'delete: no error' );
    diag $hDelete->{'Error'}->{'Message'} . "\n" if $hDelete->{'Error'};

    my $LineItemPath = "$Path/LineItemContainer/$LineItemAlias";
    ok( $hDelete->{'Path'} eq $LineItemPath, 'line item path' );
    is( $hDelete->{'deleted'}, 1, 'deleted?' );
}

sub _createBasketHash {

    return {
        'LineItemContainer' => {
            'CurrencyID' => 'EUR',
            'TaxArea'    => '/TaxMatrixGermany/EU',
            'TaxModel'   => 'gross',
        },
    };
}

sub _addProductToBasketHash {
    my ( $hBasket, $ProductAlias, $Quantity ) = @_;

    my $aProductLineItems =
      $hBasket->{'LineItemContainer'}->{'ProductLineItems'};
    $aProductLineItems = [] unless defined $aProductLineItems;
    my $hProduct = {
        'Product'   => $GUID{$ProductAlias},
        'Quantity'  => $Quantity,
        'OrderUnit' => '/Units/piece'
    };

    push( @$aProductLineItems, $hProduct );
    $hBasket->{'LineItemContainer'}->{'ProductLineItems'} = $aProductLineItems;

    return $hBasket;
}

sub _setBillingAddressOnBasketHash {

    my ($hBasket) = @_;

    $hBasket->{'BillingAddress'} = {
        'BillingAddress' => {
            'EMail'     => 'mmustermann@epages.de',
            'FirstName' => 'Max',
            'LastName'  => 'Mustermann',
            'Street'    => 'Musterstrasse 2',
            'Street2'   => 'Ortsteil Niederfingeln',
            'CodePorte' => '13a',
        },
    };

    return $hBasket;
}

sub testCreateBasket {
    my $hBasket = _createBasketHash;

    my $ahResults = $BasketService->create( [$hBasket] )->result;
    is( scalar @$ahResults, 1, 'testCreateBasket: response format' );

    my $hCreate = $ahResults->[0];
    ok( !$hCreate->{'Error'}, 'testCreateBasket: check error' );
    is( $hCreate->{'created'}, 1, 'testCreateBasket: created?' );
}

sub testExistsBasket {
    my $hBasket        = _createBasketHash;
    my $ahResultCreate = _createBasketInDB($hBasket);

    my $BasketPath = $ahResultCreate->[0]->{'Path'};

    my $ahResultExists = $BasketService->exists( [$BasketPath] )->result;
    is( scalar @$ahResultExists, 1, 'testExistsBasket: response format' );

    my $hExists = $ahResultExists->[0];
    ok( !$hExists->{'Error'}, 'testExistsBasket: check error' );
    diag $hExists->{'Error'}->{'Message'} . "\n" if $hExists->{'Error'};

    ok( $hExists->{'Path'} eq $BasketPath, 'testExistsBasket: basket path' );
    is( $hExists->{'exists'}, 1, 'testExistsBasket: exists?' );
}

sub testDeleteBasket       { }
sub testGetInfoFromBasket  { }
sub testUpdateBasket       { }
sub testupdateLineItem     { }
sub testdeleteLineItem     { }
sub testaddProductLineItem { }

sub _createBasketInDB {
    my ($hBasket) = @_;

    my $ahResults = $BasketService->create( [$hBasket] )->result;

    return $ahResults;
}

main();

1;

