package de.epages.ws;

import de.epages.ws.assignment.AssignmentServiceClient;
import de.epages.ws.basket.BasketServiceClient;
import de.epages.ws.catalog8.CatalogServiceClient;
import de.epages.ws.product11.ProductServiceClient;

/**
 * Interface to the latest implementations of the epages6 webservices.
 */
public interface WebServiceFactory {

    AssignmentServiceClient createAssignmentServiceClient(WebServiceConfiguration config);

    BasketServiceClient createBasketServiceClient(WebServiceConfiguration config);

    CatalogServiceClient createCatalogServiceClient(WebServiceConfiguration config);

    ProductServiceClient createProductServiceClient(WebServiceConfiguration config);

}