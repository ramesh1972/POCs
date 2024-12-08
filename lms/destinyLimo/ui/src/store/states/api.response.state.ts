export interface ApiResponseState {
    HttpCode: number;
    success: boolean;
    msg: string;
    error: string;
    data: any;
}