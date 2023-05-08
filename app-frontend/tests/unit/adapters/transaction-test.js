import { module, test } from 'qunit';

import { setupTest } from 'app-frontend/tests/helpers';

module('Unit | Adapter | transaction', function (hooks) {
  setupTest(hooks);

  // Replace this with your real tests.
  test('it exists', function (assert) {
    let adapter = this.owner.lookup('adapter:transaction');
    assert.ok(adapter);
  });
});
