import JSONAPISerializer from '@ember-data/serializer/json-api';

export default class TransactionSerializer extends JSONAPISerializer {
  keyForAttribute(key) {
    return key;
  }

  normalizeResponse(store, primaryModelClass, payload, id, requestType) {
    payload = {
      data: payload.data.transactions.map((transaction) => ({
        id: transaction.transaction_id,
        type: primaryModelClass.modelName,
        attributes: {
          transactionId: transaction.transaction_id,
          amount: transaction.transaction_amount,
          accountId: transaction.account_id,
          accountBalance: transaction.account_balance,
          createdAt: transaction.created_at,
        },
      })),
    };

    return super.normalizeResponse(
      store,
      primaryModelClass,
      payload,
      id,
      requestType
    );
  }
}
