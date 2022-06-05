import { Stat } from '../stores';

export type CalculateSaveThrowOptions = { stat: Stat; proficiency: number };

export function calculateSaveThrow({ stat, proficiency }: CalculateSaveThrowOptions) {
  if (stat.isSaveProf) {
    return stat.mod + proficiency;
  }

  return stat.mod;
}
