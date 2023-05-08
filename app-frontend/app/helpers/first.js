import { helper } from '@ember/component/helper';

export function first([array]) {
  if (!Array.isArray(array)) {
    return [];
  }

  return array[array.length - 1];
}

export default helper(first);
