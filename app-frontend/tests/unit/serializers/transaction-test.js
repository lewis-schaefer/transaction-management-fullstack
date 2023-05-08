import { module, test } from 'qunit';

import { setupTest } from 'app-frontend/tests/helpers';

module('Unit | Serializer | transaction', function (hooks) {
  setupTest(hooks);

  // Replace this with your real tests.
  test('it exists', function (assert) {
    let store = this.owner.lookup('service:store');
    let serializer = store.serializerFor('transaction');

    assert.ok(serializer);
  });

  test('it serializes records', function (assert) {
    let store = this.owner.lookup('service:store');
    let record = store.createRecord('transaction', {});

    let serializedRecord = record.serialize();

    assert.ok(serializedRecord);
  });
});
