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

my $Product_alias_1 = "productalias1";
my $Product_alias_2 = "productalias2";

# create test products
my $Product_in_1 = {
    'Alias'      => $Product_alias_1,
    'StockLevel' => 200,
    'ProductPrices' =>
      [ { 'CurrencyID' => 'EUR', 'Price' => 123, 'TaxModel' => 'gross', }, ],
    'IsAvailable' => SOAP::Data->type('boolean')->value(1)
};

my $Product_in_2 = {
    'Alias'      => $Product_alias_2,
    'StockLevel' => 300,
    'ProductPrices' =>
    [ { 'CurrencyID' => 'EUR', 'Price' => 1234, 'TaxModel' => 'gross', }, ],
    'IsAvailable' => SOAP::Data->type('boolean')->value(1)
};

sub main {
    init();
    test();
    done_testing();
}

sub init() {
    _cleanup();
}

sub test {
    testCreateBasket();
    testExistsBasket();
    testDeleteBasket();
    testaddProductLineItem();
    testGetInfoReference();
    testUpdateLineItem();
    testDeleteLineItem();
    testUpdateBasket();
}

sub testCreateBasket {
    my $hBasket = _createBasketHash();
    my $ahResults = $BasketService->create( [$hBasket] )->result;

    is( scalar @$ahResults, 1, 'testCreateBasket: response format' );

    my $hCreate = $ahResults->[0];
    ok( !$hCreate->{'Error'}, 'testCreateBasket: check error' );
    is( $hCreate->{'created'}, 1, 'testCreateBasket: created' );
}

sub testDeleteLineItem {
    my $BasketPath = _setupTestBasket();

    _createProducts( [$Product_in_1] );
    my $ProductGUID = _fetch_product_guid($Product_alias_1);

    my $ProductLineItem = {
        'GUID'     => $ProductGUID,
        'Quantity' => 50,
    };
    $BasketService->addProductLineItem( $BasketPath, [$ProductLineItem] )
      ->result;

    my $hCreatedBasket = _getInfoReference($BasketPath);

    my $LineItemAlias =
      $hCreatedBasket->{LineItemContainer}->{'ProductLineItems'}->[0]->{'Alias'};

    my $ahResults =
        $BasketService->deleteLineItem( $BasketPath, [$LineItemAlias] )->result;
    is( scalar @$ahResults, 1, 'testDeleteLineItem: result count' );

    my $hDelete = $ahResults->[0];
    ok( !$hDelete->{'Error'}, 'testDeleteLineItem: check error' );
    diag $hDelete->{'Error'}->{'Message'} . "\n" if $hDelete->{'Error'};

    my $LineItemPath = "$BasketPath/LineItemContainer/$LineItemAlias";
    ok( $hDelete->{'Path'} eq $LineItemPath, 'testDeleteLineItem: line item path' );
    is( $hDelete->{'deleted'}, 1, 'testDeleteLineItem: deleted' );
}

sub testExistsBasket {
    my $BasketPath = _setupTestBasket();

    my $ahResultExists = $BasketService->exists( [$BasketPath] )->result;
    is( scalar @$ahResultExists, 1, 'testExistsBasket: response format' );

    my $hExists = $ahResultExists->[0];
    ok( !$hExists->{'Error'}, 'testExistsBasket: check error' );
    diag $hExists->{'Error'}->{'Message'} . "\n" if $hExists->{'Error'};

    ok( $hExists->{'Path'} eq $BasketPath, 'testExistsBasket: basket path' );
    is( $hExists->{'exists'}, 1, 'testExistsBasket: exists' );
}

sub testDeleteBasket {
    my $BasketPath = _setupTestBasket();

    my $ahResults = $BasketService->delete( [$BasketPath] )->result;
    is( scalar @$ahResults, 1, 'testDeleteBasket: result count' );

    my $hDelete = $ahResults->[0];
    ok( !$hDelete->{'Error'}, 'testDeleteBasket: check error' );
    diag $hDelete->{'Error'}->{'Message'} . "\n" if $hDelete->{'Error'};

    ok( $hDelete->{'Path'} eq $BasketPath, 'testDeleteBasket: basket path' );
    is( $hDelete->{'deleted'}, 1, 'testDeleteBasket: deleted' );
}

sub testaddProductLineItem {
    my $BasketPath     = _setupTestBasket();

    my $Quantity = 200;

    _createProducts( [$Product_in_1] );
    my $ProductGUID = _fetch_product_guid($Product_alias_1);

    my $LineItem = {
        'GUID'     => $ProductGUID,
        'Quantity' => $Quantity,
    };

    my $ahResults =
      $BasketService->addProductLineItem( $BasketPath, [$LineItem] )->result;
    is( scalar @$ahResults, 1, 'testaddProductLineItem: result count' );

    my $hAddProducts = $ahResults->[0];
    ok( !$hAddProducts->{'Error'}, 'testaddProductLineItem: check error' );
    diag $hAddProducts->{'Error'}->{'Message'} . "\n"
      if $hAddProducts->{'Error'};

    ok(
        $hAddProducts->{'GUID'} eq $LineItem->{GUID},
        'testaddProductLineItem: product GUID'
    );
    is( $hAddProducts->{'added'}, 1, 'testaddProductLineItem: added' );
}

sub testGetInfoReference {
    my $BasketPath     = _setupTestBasket();
    my $Quantity       = '170';

    _createProducts( [$Product_in_1] );
    my $ProductGUID = _fetch_product_guid($Product_alias_1);

    _addProductToBasketHash( $hBasket, $ProductGUID, $Quantity );

    my $LineItem = {
        'GUID'     => $ProductGUID,
        'Quantity' => $Quantity
    };
    $BasketService->addProductLineItem( $BasketPath, [$LineItem] );

    my $ahResults = $BasketService->getInfo( [$BasketPath], [], [] )->result;
    is( scalar @$ahResults, 1, 'testGetInfoReference: result set' );

    my $hInfo = $ahResults->[0];
    ok( !$hInfo->{'Error'}, 'testGetInfoReference: check error' );
    diag "Error: $hInfo->{'Error'}\n" if $hInfo->{'Error'};

    my $hLineItemContainer  = $hInfo->{'LineItemContainer'};
    my $hLineItemContainer2 = $hBasket->{'LineItemContainer'};
    ok(
        $hLineItemContainer->{'TaxArea'} eq $hLineItemContainer2->{'TaxArea'},
        'testGetInfoReference: tax area',
    );
    ok(
        $hLineItemContainer->{'TaxModel'} eq $hLineItemContainer2->{'TaxModel'},
        'testGetInfoReference: tax model'
    );
    ok(
        $hLineItemContainer->{'CurrencyID'} eq
          $hLineItemContainer2->{'CurrencyID'},
        'testGetInfoReference: currencyid'
    );

    ok( $hLineItemContainer->{'ProductLineItems'},
        'testGetInfoReference: list of all product line items' );
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
        'testGetInfoReference: product line items' );

    return $hInfo;
}

sub testUpdateLineItem {
    my $BasketPath     = _setupTestBasket();
    my $ChangeQuantity = '17';

    _createProducts( [$Product_in_1] );
    my $ProductGUID = _fetch_product_guid($Product_alias_1);

    my $ProductLineItem = {
        'GUID'     => $ProductGUID,
        'Quantity' => 50,
    };
    $BasketService->addProductLineItem( $BasketPath, [$ProductLineItem] )
      ->result;
    my $hCreatedBasket = _getInfoReference($BasketPath);

    my $hContainer      = $hCreatedBasket->{LineItemContainer};
    my $hLineItem       = $hContainer->{'ProductLineItems'}->[0];
    my $changedQuantity = $ChangeQuantity;
    my $LineItem        = {
        'Alias'     => $hLineItem->{Alias},
        'Quantity'  => $changedQuantity,
        'OrderUnit' => '/Units/piece'
    };

    my $ahResults =
      $BasketService->updateLineItem( $BasketPath, [$LineItem] )->result;
    is( scalar @$ahResults, 1, 'testUpdateLineItem: result count' );

    my $hUpdate = $ahResults->[0];
    ok( !$hUpdate->{'Error'}, 'testUpdateLineItem: check error' );
    diag $hUpdate->{'Error'}->{'Message'} . "\n" if $hUpdate->{'Error'};

    my $LineItemPath = "$BasketPath/LineItemContainer/$LineItem->{Alias}";
    ok(
        $hUpdate->{'Path'} eq $LineItemPath,
        'testUpdateLineItem: line item path'
    );
    is( $hUpdate->{'updated'}, 1, 'testUpdateLineItem: updated' );
}

sub testUpdateBasket {
    my $BasketPath     = _setupTestBasket();

    _createProducts( [$Product_in_1, $Product_in_2] );
    my $ProductGUID_1 = _fetch_product_guid($Product_alias_1);
    my $ProductGUID_2 = _fetch_product_guid($Product_alias_2);

    my $ProductLineItem = {
        'GUID'     => $ProductGUID_1,
        'Quantity' => 50,
    };
    $BasketService->addProductLineItem( $BasketPath, [$ProductLineItem] )
        ->result;

    my $UpdateBasket =
        { 'LineItemContainer' => {
            'CurrencyID'       => 'EUR',
            'TaxArea'          => '/TaxMatrixGermany/EU',
            'TaxModel'         => 'gross',
            'ProductLineItems' => [
                { 'Product' => $ProductGUID_2, 'Quantity' => '1' },
            ],
        },
    };
    $UpdateBasket->{Path} = $BasketPath;

    my $ahResults = $BasketService->update( [$UpdateBasket] )->result;
    is( scalar @$ahResults, 1, 'update: result count' );

    my $hUpdate = $ahResults->[0];
    ok( !$hUpdate->{'Error'}, 'update: no error' );
    diag $hUpdate->{'Error'}->{'Message'} . "\n" if $hUpdate->{'Error'};

    ok( $hUpdate->{'Path'} eq $BasketPath, 'path path' );
    is( $hUpdate->{'updated'}, 1, 'updated?' );
}

sub _setupTestBasket {
    my $hBasket = _createBasketHash();
    my $ahResultCreate = $BasketService->create( [$hBasket] )->result;
    return $ahResultCreate->[0]->{'Path'};
}

sub _createProducts {
    my ($aProducts) = @_;

    foreach my $Product ($aProducts) {
        $ProductService->create($Product)->result;
    }

}

sub _deleteProductsIfExists {
    my ($aProductAliases) = @_;

    foreach my $Alias ($aProductAliases) {
        my $ahResults =
            $ProductService->exists( [ '/Shops/DemoShop/Products/' . $Alias ] )
                ->result;

        next unless $ahResults->[0]->{'exists'};

        $ProductService->delete( [ '/Shops/DemoShop/Products/' . $Alias ] );
    }

    return;
}

sub _fetch_product_guid {
    my ($Product) = @_;

    # array of product paths that involved in basket tests
    my @ProductPaths = map "Products/$_", ($Product);
    my $prodInfoResult =
      $ProductService->getInfo( \@ProductPaths, ['GUID'] )->result;
    ok( !$prodInfoResult->[0]->{'Error'}, "_fetch_product_guid: no error" );

    return ( @$prodInfoResult[0]->{Attributes}->[0]->{Value} );
}

sub _createBasketInDB {
    my ($hBasket) = @_;

    my $ahResults = $BasketService->create( [$hBasket] )->result;

    return $ahResults;
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
    my ( $hBasket, $GUID, $Quantity ) = @_;

    my $aProductLineItems =
      $hBasket->{'LineItemContainer'}->{'ProductLineItems'};
    $aProductLineItems = [] unless defined $aProductLineItems;
    my $hProduct = {
        'Product'   => $GUID,
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

sub _getInfoReference {
    my ($basketPath) = @_;

    my $ahResults = $BasketService->getInfo( [$basketPath], [], [] )->result;

    return $ahResults->[0];
}

sub _cleanup {
    _deleteProductsIfExists( [$Product_alias_1, $Product_alias_2] );
}

main();

1;
