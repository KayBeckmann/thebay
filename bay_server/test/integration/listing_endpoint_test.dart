import 'package:test/test.dart';
import 'package:bay_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given ListingEndpoint', (sessionBuilder, endpoints) {
    late User testUser;
    late Category testCategory;

    setUp(() async {
      // Create test user
      testUser = (await endpoints.auth.register(
        sessionBuilder,
        username: 'seller',
        password: 'TestPass123!',
        acceptedTerms: true,
      ))!;

      // Create test category
      testCategory = (await endpoints.category.create(
        sessionBuilder,
        name: 'Test Category',
        parentId: null,
      ))!;
    });

    group('Listing Creation', () {
      test('when creating listing with valid data then listing is created',
          () async {
        final listing = await endpoints.listing.create(
          sessionBuilder,
          title: 'Test Product',
          description: 'Test Description',
          priceCents: 10000,
          categoryId: testCategory.id!,
        );

        expect(listing, isNotNull);
        expect(listing?.title, 'Test Product');
        expect(listing?.priceCents, 10000);
        expect(listing?.isActive, isTrue);
      });

      test('when creating listing with negative price then throws exception',
          () async {
        expect(
          () => endpoints.listing.create(
            sessionBuilder,
            title: 'Invalid Product',
            description: 'Test Description',
            priceCents: -100,
            categoryId: testCategory.id!,
          ),
          throwsA(anything),
        );
      });
    });

    group('Listing Retrieval', () {
      late Listing testListing;

      setUp(() async {
        testListing = (await endpoints.listing.create(
          sessionBuilder,
          title: 'Retrieval Test Product',
          description: 'Test Description',
          priceCents: 5000,
          categoryId: testCategory.id!,
        ))!;
      });

      test('when getting listing by id then returns correct listing',
          () async {
        final listing = await endpoints.listing.getById(
          sessionBuilder,
          testListing.id!,
        );

        expect(listing, isNotNull);
        expect(listing?.id, testListing.id);
        expect(listing?.title, 'Retrieval Test Product');
      });

      test('when getting non-existent listing then returns null', () async {
        final listing = await endpoints.listing.getById(
          sessionBuilder,
          99999,
        );

        expect(listing, isNull);
      });
    });

    group('Listing Update', () {
      late Listing testListing;

      setUp(() async {
        testListing = (await endpoints.listing.create(
          sessionBuilder,
          title: 'Original Title',
          description: 'Original Description',
          priceCents: 10000,
          categoryId: testCategory.id!,
        ))!;
      });

      test('when updating listing then changes are persisted', () async {
        final updated = await endpoints.listing.update(
          sessionBuilder,
          listingId: testListing.id!,
          title: 'Updated Title',
          description: 'Updated Description',
          priceCents: 15000,
          categoryId: testCategory.id!,
        );

        expect(updated, isNotNull);
        expect(updated?.title, 'Updated Title');
        expect(updated?.description, 'Updated Description');
        expect(updated?.priceCents, 15000);
      });
    });

    group('Listing Deletion', () {
      test('when deleting listing then it is removed', () async {
        final listing = (await endpoints.listing.create(
          sessionBuilder,
          title: 'To Delete',
          description: 'Will be deleted',
          priceCents: 1000,
          categoryId: testCategory.id!,
        ))!;

        final success = await endpoints.listing.delete(
          sessionBuilder,
          listing.id!,
        );

        expect(success, isTrue);

        // Verify it's deleted
        final retrieved = await endpoints.listing.getById(
          sessionBuilder,
          listing.id!,
        );
        expect(retrieved, isNull);
      });
    });
  });
}
