import { MaterialCategory } from './MaterialCategory';

export interface MaterialWithCategory<T> {
    materials: T[];
    categories: MaterialCategory[];
}