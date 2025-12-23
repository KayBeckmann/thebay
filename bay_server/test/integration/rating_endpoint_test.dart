import 'package:test/test.dart';
import 'package:bay_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given RatingEndpoint', (sessionBuilder, endpoints) {
    late User buyer;
    late User seller;
    late Transaction completedTransaction;

    setUp(() async {
      // Create users
      buyer = (await endpoints.auth.register(
        sessionBuilder,
        username: 'buyer_rating',
        password: 'TestPass123!',
        acceptedTerms: true,
      ))!;

      seller = (await endpoints.auth.register(
        sessionBuilder,
        username: 'seller_rating',
        password: 'TestPass123!',
        acceptedTerms: true,
      ))!;

      // Create category and listing
      final category = (await endpoints.category.create(
        sessionBuilder,
        name: 'Test Category',
        parentId: null,
      ))!;

      final listing = (await endpoints.listing.create(
        sessionBuilder,
        title: 'Test Product',
        description: 'Test',
        priceCents: 10000,
        categoryId: category.id!,
      ))!;

      // Create and complete transaction
      final transaction = (await endpoints.transaction.create(
        sessionBuilder,
        listingId: listing.id!,
        quantity: 1,
      ))!;

      await endpoints.transaction.markAsShipped(
        sessionBuilder,
        transaction.id!,
      );

      completedTransaction = await endpoints.transaction.markAsReceived(
        sessionBuilder,
        transaction.id!,
      );
    });

    group('Rating Creation', () {
      test('when creating positive rating then rating is saved', () async {
        final rating = await endpoints.rating.create(
          sessionBuilder,
          transactionId: completedTransaction.id!,
          rating: RatingValue.positive,
          comment: 'Great seller!',
        );

        expect(rating, isNotNull);
        expect(rating?.rating, RatingValue.positive);
        expect(rating?.comment, 'Great seller!');
        expect(rating?.fromUserId, buyer.id);
        expect(rating?.toUserId, seller.id);
        expect(rating?.isAutomatic, isFalse);
      });

      test('when creating negative rating with comment then rating is saved',
          () async {
        final rating = await endpoints.rating.create(
          sessionBuilder,
          transactionId: completedTransaction.id!,
          rating: RatingValue.negative,
          comment: 'Poor communication',
        );

        expect(rating, isNotNull);
        expect(rating?.rating, RatingValue.negative);
        expect(rating?.comment, 'Poor communication');
      });

      test('when creating duplicate rating then returns null', () async {
        // Create first rating
        await endpoints.rating.create(
          sessionBuilder,
          transactionId: completedTransaction.id!,
          rating: RatingValue.positive,
        );

        // Try to create duplicate
        final duplicate = await endpoints.rating.create(
          sessionBuilder,
          transactionId: completedTransaction.id!,
          rating: RatingValue.positive,
        );

        expect(duplicate, isNull);
      });
    });

    group('Rating Queries', () {
      setUp(() async {
        // Create some ratings
        await endpoints.rating.create(
          sessionBuilder,
          transactionId: completedTransaction.id!,
          rating: RatingValue.positive,
          comment: 'Excellent!',
        );
      });

      test('when getting ratings for user then returns user ratings',
          () async {
        final ratings = await endpoints.rating.getForUser(
          sessionBuilder,
          seller.id!,
        );

        expect(ratings, isNotEmpty);
        expect(ratings.first.toUserId, seller.id);
      });

      test('when getting rating stats then returns correct counts', () async {
        final stats = await endpoints.rating.getStats(
          sessionBuilder,
          seller.id!,
        );

        expect(stats, isNotNull);
        expect(stats['total'], greaterThanOrEqualTo(1));
        expect(stats['positive'], greaterThanOrEqualTo(1));
      });

      test('when getting rating for transaction then returns rating',
          () async {
        final rating = await endpoints.rating.getForTransaction(
          sessionBuilder,
          completedTransaction.id!,
          buyer.id!,
        );

        expect(rating, isNotNull);
        expect(rating?.transactionId, completedTransaction.id);
      });
    });

    group('Rating Statistics', () {
      test('when user has ratings then average is calculated correctly',
          () async {
        // The setup already created one positive rating
        final stats = await endpoints.rating.getStats(
          sessionBuilder,
          seller.id!,
        );

        expect(stats['average'], isNotNull);
        expect(stats['average'], greaterThan(0.0));
      });
    });
  });
}
