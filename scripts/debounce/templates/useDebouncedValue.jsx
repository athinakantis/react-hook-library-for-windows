import { useEffect, useState } from 'react'

export const useDebouncedValue = (value, delay) => {
  const [debouncedValue, setDebouncedValue] = useState(value);
  const [TO, setTO] = useState(null)

  useEffect(() => {
    if (TO) clearTimeout(TO)
    setTO(setTimeout(() => setDebouncedValue(value), delay))
  }, [value])

  return debouncedValue;
}