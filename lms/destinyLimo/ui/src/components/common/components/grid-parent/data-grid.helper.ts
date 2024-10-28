import * as VTable from '@visactor/vtable';
import { SearchComponent } from '@visactor/vtable-search';
import { Store } from '@ngrx/store';
import { bulkUpdate } from '@src/store/actions/bulk-update.action';

export class DataGridComponentHelper {

    constructor(compRef: any, private readonly store: Store) {
        this.compRef = compRef;
    }

    compRef?: any;
    editHandlers: any = [];
    table?: VTable.ListTable;
    tableOptions: any = {};
    searchHandle?: SearchComponent;

    tableName: string = '';
    idColName: string = '';
    parentTableName: string = '';
    parentTableIdColName: string = '';

    is_soft_delete: boolean = false;
    mandatoryColumns: any = [];

    data: any = [];
    columns: any = [];
    originalColumns: any = [];

    originalData: any = [];
    dataChanges: any = [];
    filesToBeUploaded: any[] = [];

    setTableInfo(tableName: string, idColName: string, is_soft_delete: boolean = false, mandatoryColumns: any = []) {
        this.tableName = tableName;
        this.idColName = idColName;
        this.mandatoryColumns = mandatoryColumns;
        this.is_soft_delete = is_soft_delete;
    }

    setParentTableInfo(parentTableName: string, parentTableIdColName: string) {
        this.parentTableName = parentTableName;
        this.parentTableIdColName = parentTableIdColName;
    }

    setColumns(columns: any) {
        this.columns = columns;
        this.originalColumns = [...columns];

        // add delete column
        this.addDefaultEditColumns();
    }

    setEditorHandlers(editHandlers: any) {
        this.editHandlers = editHandlers;
    }

    setData(data: any) {
        console.log('Resp Data:', data);

        this.data = data.map((record: any) => {
            return {
                ...record
            };
        });

        this.originalData = data.map((record: any) => {
            return {
                ...record
            };
        });
    }

    registerEditors(editors: any) {
        editors.forEach((editor: any) => {
            VTable.register.editor(editor.name, editor.editor);
        });
    }

    createTable(option: any) {
        this.tableOptions = option;
        this.table = new VTable.ListTable(option);

        console.log("new data to set", this.data);
        this.table.setRecords(this.data);

        this.init();
    }

    init() {
        console.log('datagrid component helper initialized');

        // setup search component
        this.searchHandle = new SearchComponent({
            table: this.table!,
            autoJump: true // Whether to automatically jump to the first search result after the search is completed
        });

        // register events
        this.setManageEvents();
    }

    addDefaultEditColumns() {
        if (this.mandatoryColumns.find((col: any) => col.colName === 'is_public') !== undefined) {
            this.columns.push({
                title: "Is Public", field: "is_public",
                cellType: 'checkbox',
                width: 65,
                columnResizeMode: 'none',
                disableColumnResize: true,
                style: {
                    textAlign: 'center',
                    bgColor: 'rgba(184, 132, 132, 0.1)',
                    textBaseline: "middle",
                },
            });
        }

        if (this.mandatoryColumns.find((col: any) => col.colName === 'is_active') !== undefined) {
            this.columns.push({
                title: "Active", field: "is_active",
                cellType: 'checkbox',
                width: 55,
                columnResizeMode: 'none',
                disableColumnResize: true,
                style: {
                    textAlign: 'center',
                    bgColor: 'rgba(184, 132, 132, 0.1)',
                    textBaseline: "middle",
                },
            });
        }

        if (this.mandatoryColumns.find((col: any) => col.colName === 'is_deleted') !== undefined) {
            this.columns.push({
                field: 'XYZ',
                title: 'Delete',
                width: 55,
                columnResizeMode: 'none',
                disableColumnResize: true,
                style: {
                    textAlign: 'center',
                    bgColor: 'rgba(184, 132, 132, 0.1)',
                    textBaseline: "middle",
                },
                icon: [
                    {
                        name: 'delete',
                        type: 'svg',
                        positionType: VTable.TYPES.IconPosition.left,
                        marginLeft: 17,
                        width: 20,
                        height: 20,
                        svg: '/images/buttons/delete.svg',
                        tooltip: {
                            title: 'delete',
                            placement: VTable.TYPES.Placement.right
                        }
                    }
                ]
            });
        }
    }

    onAppendEmptyRecord() {
        console.log('onAppendEmptyRecord');
        const is_active = this.columns.find((col: any) => col.field === 'is_active');
        const is_public = this.columns.find((col: any) => col.field === 'is_public');

        var record = {};
        if (is_active && is_public) {
            record = { "is_active": true, "is_public": true };
        }
        else if (is_active) {
            record = { "is_active": true };
        }
        else if (is_public) {
            record = { "is_public": true };
        }

        record = { ...record, "is_new": true };

        this.table?.addRecord(record);

        //this.table?.updateOption(this.tableOptions);

        this.table?.scrollToCell({ row: this.table.rowCount });

        this.compRef.saveButtonEnabled = true;
        this.compRef.resetButtonEnabled = true;
    }

    onNewRecord(col: string, rowNum: number, value: any) {
        console.log('onNewRecord', col, rowNum, value);
        console.log('onNewRecord dataChanges', this.dataChanges);

        var index = this.dataChanges.filter((change: any) => change.action === 'insert' && change.rowNum === rowNum);
        console.log('OnNewRecord index', index);

        if (index.length > 0) {
            console.log('found record', col, rowNum, value);
            var found = index[0].records.find((insert: any) => insert.colName === col);
            if (found) {
                found.value = value;
                return;
            }
            else {
                index[0].records.push({ colName: col, value: value });
                return;
            }
        }

        console.log('new record', col, rowNum, value);
        const newRec = { action: 'insert', rowNum: rowNum, records: [{ colName: col, value: value }] };
        this.dataChanges.push(newRec);

        // add the mandatory columns
        console.log('mandatoryColumns', this.mandatoryColumns);

        this.mandatoryColumns.forEach((col: any) => {
            if (!newRec.records.find((insertCol: any) => insertCol.colName === col.colName)) {
                newRec.records.push({ colName: col.colName, value: col.defaultValue });
            }
        });

        console.log('OnNewRecord changedValues2', this.dataChanges);
    }

    onUpdateRecord(id: number, col: any, value: any, parentId: number = -1) {
        console.log('onUpdateRecord', id, col, value);
        console.log('onUpdateRecord dataChanges', this.dataChanges);

        // get any previous update to the same record and column
        const index = this.dataChanges.findIndex((change: any) => change.action === 'update' && change.idCol === id);
        if (index > -1) {
            var found = this.dataChanges[index].records.find((update: any) => update.colName === col);
            if (found) {
                found.value = value;
                return;
            }

            this.dataChanges[index].records.push({ colName: col, value: value });

            console.log('onUpdateRecord changedValues2', this.dataChanges);
            return;
        }

        // if new entry 
        var records2 = [{ colName: col, value: value }];
        if (parentId !== -1)
            records2.push({ colName: this.parentTableIdColName, value: parentId });

        this.dataChanges.push({ action: 'update', idCol: id, parentTableName: this.parentTableName, records: records2 });

        console.log('onUpdateRecord changedValues3', this.dataChanges);

        this.compRef.resetButtonEnabled = true;
        this.compRef.saveButtonEnabled = true;
    }

    isFile(fileName: string): boolean {
        // Regular expression to check for common file extensions
        const fileExtensionPattern = /\.(jpg|jpeg|png|gif|pdf|doc|docx|xls|xlsx|ppt|pptx|txt|csv|zip|rar|tar|gz|mp3|mp4|avi|mkv|mov|wmv|flv|webm|htm|html)$/i;
        return fileExtensionPattern.test(fileName);
    }

    onDeleteRecord(id: number, parentId: number = -1) {
        console.log('onDeleteRecord', id, parentId);

        if (this.is_soft_delete) {
            this.onUpdateRecord(id, 'is_deleted', "true", parentId);

            if (this.compRef.onDeleteRecord)
                this.compRef.onDeleteRecord(id);

            return;
        }

        const index = this.dataChanges.findIndex((change: any) => change.action === 'update' || change.action === "insert" && change.idCol === id);
        console.log('index', index);
        if (index > -1) {
            this.dataChanges.splice(index, 1);
        }

        this.dataChanges.push({ action: 'delete', idCol: id });

        console.log('changedValues', this.dataChanges);

        this.compRef.resetButtonEnabled = true;
        this.compRef.saveButtonEnabled = true;

        if (this.compRef.onDeleteRecord)
            this.compRef.onDeleteRecord(id);
    }

    onSaveRecords() {
        // dispatch the changes
        console.log('onSaveRecords', this.dataChanges);

        if (this.dataChanges.length === 0) {
            console.warn('no changes to save');
            return;
        }


        this.dataChanges[0].idColName = this.idColName;

        console.log('onSaveRecords idColName', this.idColName);
        console.log('onSaveRecords filesToBeUploaded', this.filesToBeUploaded);
        console.log('onSaveRecords dataChanges', this.dataChanges);

        if (this.store) {
            console.log('onSaveRecords dispatching bulk update');
            this.store?.dispatch(bulkUpdate({ tableName: this.tableName, allActionRecords: this.dataChanges, allFileUploads: this.filesToBeUploaded }));
            console.log('onSaveRecords dispatched bulk update');
        }
        else
            console.warn('store not set');

        // maka a new copy of the original data which is the updated data
        const newData = this.table?.records.map((record: any) => {
            return {
                ...record
            };
        }) ?? [];

        this.originalData = [...newData];
        this.dataChanges = [];
        this.filesToBeUploaded = [];

        this.compRef.saveButtonEnabled = false;
        this.compRef.resetButtonEnabled = false;
    }

    resetChanges() {
        console.log('resetChanges');

        console.log('reset originalData', this.originalData);
        const originalData = this.originalData.map((record: any) => {
            return {
                ...record
            };
        });

        this.table?.setRecords([...originalData]);

        this.dataChanges = [];

        this.compRef.saveButtonEnabled = false;
        this.compRef.resetButtonEnabled = false;
    }

    setManageEvents() {
        this.table?.on('click_cell', args => {
            console.log('click_cell', args);

            const { col, row, targetIcon, cellType } = args;

            const record = this.table?.getRecordByCell(col, row);

            var parentId = -1;
            if (this.parentTableName !== '')
                parentId = record[this.parentTableIdColName];

            const pk_id = record !== undefined || record !== null ? record[this.idColName] : -1;

            if (targetIcon) {
                if (targetIcon.name === 'delete') {
                    const value = this.table?.getRecordByCell(1, row);
                    if (pk_id === undefined || pk_id === null || pk_id === -1) {
                        this.table?.deleteRecords([row - 1]);
                        return;
                    }

                    this.table?.deleteRecords([row - 1]);
                    this.onDeleteRecord(pk_id, parentId);
                }
            }

            if (cellType === 'checkbox') {
                const record = this.table?.getRecordByCell(col, row);
                console.log('checkbox', record);

                console.log('pre checkbox value', record[this.columns[col].field]);
                record[this.columns[col].field] = !record[this.columns[col].field];
                console.log('changed checkbox value', record[this.columns[col].field]);

                if (pk_id === undefined || pk_id === null || pk_id === -1) {
                    this.onNewRecord(this.columns[col].field, row, record[this.columns[col].field].toString());
                }
                else
                    this.onUpdateRecord(pk_id, this.columns[col].field, record[this.columns[col].field].toString(), parentId);

                this.disableRowEditing(row, !record[this.columns[col].field]);
            }
        });

        this.table?.on('change_cell_value', args => {
            console.log('change_cell_value', args);

            const { col, row } = args;

            const record = this.table?.getRecordByCell(col, row);
            const currentValue = args.currentValue;
            const changedValue = args.changedValue;

            console.log('record', record);
            console.log('currentValue', currentValue);
            console.log('changedValue cell value change', changedValue);

            const fieldDef = this.columns[col];
            const colName = this.columns[col].field;
            console.log('colName', colName);

            // get any vlues from the edit handlers
            let changedValues: any[] = [];
            if (this.editHandlers.length > 0) {
                const handler = this.editHandlers.find((editHandler: any) => editHandler.col === colName);
                if (handler) {
                    changedValues = handler.handler(record, args.changedValue);

                    console.log('changedValues handler', changedValues);
                }
            }

            // the pk id of the record
            const pk_id = record !== undefined || record !== null ? record[this.idColName] : -1;

            if (changedValues?.length === 0) {
                if (pk_id === undefined || pk_id === null || pk_id === -1) {
                    this.onNewRecord(fieldDef.field, row, args.changedValue);
                }
                else {
                    if (currentValue === changedValue) {
                        console.log('no change in value');
                        return;
                    }

                    const id = record.id;
                    var parentId = -1;
                    if (this.parentTableName !== '')
                        parentId = record[this.parentTableIdColName];

                    console.log('update record', record, fieldDef.field, args.changedValue);
                    this.onUpdateRecord(pk_id, fieldDef.field, args.changedValue, parentId);
                }
            }
            else {
                var parentId = -1;
                if (this.parentTableName !== '')
                    parentId = record[this.parentTableIdColName];

                changedValues?.forEach((changedValue2: any) => {
                    console.log('changedValues record', changedValue2);

                    if (this.isFile(changedValue2.value?.name)) {
                        console.log('file upload', changedValue2.value.name);
                        this.filesToBeUploaded.push(changedValue2.value);
                    }
                    else if (changedValue2.value === null || changedValue2.value === undefined) {
                        console.log('null value');
                    }
                    else {
                        if (pk_id === undefined || pk_id === null || pk_id === -1) {
                            console.log('new record', changedValue2.field, row, changedValue2.value);
                            this.onNewRecord(changedValue2.field, row, changedValue2.value);
                        }
                        else {
                            var currentValue2 = record[changedValue2.field];
                            if (currentValue2 !== changedValue2.value) {
                                console.log('change in value');

                                console.log('new record', changedValue2);
                                this.onUpdateRecord(pk_id, changedValue2.field, changedValue2.value, parentId);
                            }
                        }
                    }
                });
            }

            console.log('change_cell_value values', col, row);
        });
    }

    disableRowEditing(row: any, disable: boolean = true) {
        // style the row of this cell to grey if the checkbox is unchecked
        if (disable) {
            console.log('checked setting style');
            for (let i = 0; i < this.table!.columns.length; i++) {
                var cellStyle = this.table?.getCellStyle(i, row);
                console.log('setting style', cellStyle);
                cellStyle!.bgColor = 'lightgrey';
                console.log('style after ', cellStyle);
            }
        }
        else {
            console.log('unchecked setting style');
            this.table?.updateOption(this.tableOptions);
        }
    }
}