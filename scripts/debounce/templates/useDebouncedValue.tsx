import { useEffect, useState } from 'react'

export const useDebouncedValue = (value: any, delay: number) => {
  const [debouncedValue, setDebouncedValue] = useState<any>(value);
  const [TO, setTO] = useState<number | null>(null)

  useEffect(() => {
    if (TO) clearTimeout(TO)
    setTO(setTimeout(() => setDebouncedValue(value), delay))
  }, [value])

  return debouncedValue;
}