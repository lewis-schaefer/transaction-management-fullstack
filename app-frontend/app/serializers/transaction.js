import JSONAPISerializer from '@ember-data/serializer/json-api';

export default class TransactionSerializer extends JSONAPISerializer {
  keyForAttribute(key) {
    return key;
  }

  normalizeResponse(store, primaryModelClass, payload, id, requestType) {
    const transactions = payload.transactions.map((transaction) => ({
      id: transaction.transaction_id,
      type: primaryModelClass.modelName,
      attributes: {
        transactionId: transaction.transaction_id,
        amount: transaction.amount,
        accountId: transaction.account_id,
        accountBalance: transaction.account_balance,
        createdAt: transaction.created_at,
      },
    }));

    return super.normalizeResponse(
      store,
      primaryModelClass,
      { data: transactions },
      id,
      requestType
    );
  }
}
