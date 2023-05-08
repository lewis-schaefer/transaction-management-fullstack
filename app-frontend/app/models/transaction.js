import Model, { attr } from '@ember-data/model';

export default class TransactionModel extends Model {
  @attr('string') transactionId;
  @attr('number') amount;
  @attr('string') accountId;
  @attr('number') accountBalance;
  @attr('date') createdAt;
}
