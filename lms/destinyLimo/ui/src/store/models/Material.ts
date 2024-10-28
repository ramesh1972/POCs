export interface TrainingMaterial {
    id: number;
    material_id: number;
    material_type_id: number;
    category_name: string;
    material_category_id?: number;
    title: string;
    description: string;
    thumbnail:string;
    background_img:string;
    is_public: boolean;
    is_active: boolean;
    is_deleted: boolean;
}
