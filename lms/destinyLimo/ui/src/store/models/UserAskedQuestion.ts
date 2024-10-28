export interface UserAskedQuestion {
    id?: number;
    question?: string;
    answer?: string;
    dateAsked: Date;
    dateAnswered?: Date;
    answeredBy?: number;
    askedBy?: number;
    is_public: boolean;
    is_deleted: boolean;
    is_active: boolean;
}







