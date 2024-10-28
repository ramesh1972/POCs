import { Content } from '../models/Content';
import { ApiResponseState } from './api.response.state';

// state interface
export interface ContentState extends ApiResponseState {
    content: Content[];
}