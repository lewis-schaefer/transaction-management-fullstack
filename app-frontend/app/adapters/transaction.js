import JSONAPIAdapter from '@ember-data/adapter/json-api';

export default class TransactionAdapter extends JSONAPIAdapter {
  host = 'http://localhost:8080';
  namespace = 'api/v1';
}
