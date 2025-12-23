import 'package:test/test.dart';
import 'package:bay_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given TransactionEndpoint', (sessionBuilder, endpoints) {
    late User buyer;
    late User seller;
    late Category category;
    late Listing listing;

    setUp(() async {
      // Create test users
      buyer = (await endpoints.auth.register(
        sessionBuilder,
        username: 'buyer',
        password: 'TestPass123!',
        acceptedTerms: true,
      ))!;

      seller = (await endpoints.auth.register(
        sessionBuilder,
        username: 'seller',
        password: 'TestPass123!',
        acceptedTerms: true,
      ))!;

      // Create category and listing
      category = (await endpoints.category.create(
        sessionBuilder,
        name: 'Electronics',
        parentId: null,
      ))!;

      listing = (await endpoints.listing.create(
        sessionBuilder,
        title: 'Test Product',
        description: 'Test',
        priceCents: 10000,
        categoryId: category.id!,
      ))!;
    });

    group('Transaction Lifecycle', () {
      test('when creating transaction then status is open', () async {
        final transaction = await endpoints.transaction.create(
          sessionBuilder,
          listingId: listing.id!,
          quantity: 1,
          buyerNote: 'Please ship quickly',
        );

        expect(transaction, isNotNull);
        expect(transaction?.status, TransactionStatus.open);
        expect(transaction?.buyerId, buyer.id);
        expect(transaction?.sellerId, seller.id);
        expect(transaction?.quantity, 1);
      });

      test('when marking as shipped then status changes', () async {
        final transaction = (await endpoints.transaction.create(
          sessionBuilder,
          listingId: listing.id!,
          quantity: 1,
        ))!;

        final updated = await endpoints.transaction.markAsShipped(
          sessionBuilder,
          transaction.id!,
        );

        expect(updated.status, TransactionStatus.shipped);
        expect(updated.shippedAt, isNotNull);
        expect(updated.autoCompleteAt, isNotNull);
      });

      test('when marking as received then status is completed', () async {
        final transaction = (await endpoints.transaction.create(
          sessionBuilder,
          listingId: listing.id!,
          quantity: 1,
        ))!;

        // First mark as shipped
        await endpoints.transaction.markAsShipped(
          sessionBuilder,
          transaction.id!,
        );

        // Then mark as received
        final completed = await endpoints.transaction.markAsReceived(
          sessionBuilder,
          transaction.id!,
        );

        expect(completed.status, TransactionStatus.completed);
        expect(completed.receivedAt, isNotNull);
        expect(completed.completedAt, isNotNull);
        expect(completed.autoCompleteAt, isNull);
      });

      test('when cancelling open transaction then status is cancelled',
          () async {
        final transaction = (await endpoints.transaction.create(
          sessionBuilder,
          listingId: listing.id!,
          quantity: 1,
        ))!;

        final cancelled = await endpoints.transaction.cancel(
          sessionBuilder,
          transaction.id!,
        );

        expect(cancelled.status, TransactionStatus.cancelled);
      });
    });

    group('Transaction Queries', () {
      test('when getting completed count then returns correct number',
          () async {
        // Create and complete a transaction
        final transaction = (await endpoints.transaction.create(
          sessionBuilder,
          listingId: listing.id!,
          quantity: 1,
        ))!;

        await endpoints.transaction.markAsShipped(
          sessionBuilder,
          transaction.id!,
        );
        await endpoints.transaction.markAsReceived(
          sessionBuilder,
          transaction.id!,
        );

        final count = await endpoints.transaction.getCompletedCount(
          sessionBuilder,
          seller.id!,
        );

        expect(count, greaterThanOrEqualTo(1));
      });

      test('when getting my transactions then returns user transactions',
          () async {
        // Create transaction
        await endpoints.transaction.create(
          sessionBuilder,
          listingId: listing.id!,
          quantity: 1,
        );

        final transactions = await endpoints.transaction.getMyTransactions(
          sessionBuilder,
        );

        expect(transactions, isNotEmpty);
        expect(transactions.first.buyerId, buyer.id);
      });
    });

    group('Dispute Handling', () {
      test('when opening dispute then dispute is created', () async {
        final transaction = (await endpoints.transaction.create(
          sessionBuilder,
          listingId: listing.id!,
          quantity: 1,
        ))!;

        await endpoints.transaction.markAsShipped(
          sessionBuilder,
          transaction.id!,
        );

        final dispute = await endpoints.transaction.openDispute(
          sessionBuilder,
          transaction.id!,
          reason: 'Item not as described',
        );

        expect(dispute, isNotNull);
        expect(dispute.transactionId, transaction.id);
        expect(dispute.status, DisputeStatus.open);
        expect(dispute.reason, 'Item not as described');
      });
    });
  });
}
