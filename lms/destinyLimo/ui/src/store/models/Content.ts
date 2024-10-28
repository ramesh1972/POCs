// create an interface based on above block of commment
export interface Content {
    Id: number;
    content_type_id: number;
    title: string;
    description: string;
    is_public: boolean;
    is_active: boolean;
    is_deleted: boolean;
}
