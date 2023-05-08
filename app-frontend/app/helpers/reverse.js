import { helper } from '@ember/component/helper';

export function reverse([array]) {
  if (!Array.isArray(array)) {
    return [];
  }

  return array.slice(0, -1).reverse();
}

export default helper(reverse);
