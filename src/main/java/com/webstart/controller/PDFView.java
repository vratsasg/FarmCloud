package com.webstart.controller;

import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itextpdf.text.*;
import com.itextpdf.text.Font.FontFamily;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.webstart.DTO.ObservableMeasure;
import com.webstart.DTO.ValueTime;
import com.webstart.repository.ObservationJpaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.view.document.AbstractPdfView;

public class PDFView extends AbstractITextPdfView {

    @Override
    protected void buildPdfDocument(Map<String, Object> model, Document doc, PdfWriter writer, HttpServletRequest request, HttpServletResponse response) throws Exception {
        // get data model which is passed by the Spring container
        ObservableMeasure observableMeasure = (ObservableMeasure) model.get("observableMeasure");

        //String s = String.format("Duke's Birthday: %1$tm %1$te,%1$tY", c); //// -> s == "Duke's Birthday: May 23, 1995"
        String paragraph = String.format("Measures for %1 (%2) from end device with identifier %3",
                observableMeasure.getObservableProperty(), observableMeasure.getUnit(), observableMeasure.getIdentifier());
        doc.add(new Paragraph(paragraph));

        PdfPTable table = new PdfPTable(5);
        table.setWidthPercentage(100.0f);
        table.setWidths(new float[]{3.0f, 2.0f, 2.0f, 2.0f, 1.0f});
        table.setSpacingBefore(10);

        // define font for table header row
        Font font = FontFactory.getFont(FontFactory.HELVETICA);
        font.setColor(BaseColor.WHITE);

        // define table header cell
        PdfPCell cell = new PdfPCell();
        cell.setBackgroundColor(BaseColor.BLUE);
        cell.setPadding(5);

        // write table header
        cell.setPhrase(new Phrase("Measure sate & time", font));
        table.addCell(cell);

        cell.setPhrase(new Phrase("Measure value", font));
        table.addCell(cell);

        cell.setPhrase(new Phrase("Measure unit", font));
        table.addCell(cell);

        // write table row data
        for (ValueTime valueTime : observableMeasure.getMeasuredata()) {
            table.addCell(valueTime.getPhenomenonTime().toString());
            table.addCell(valueTime.getValue().toString());
            table.addCell(observableMeasure.getUnit());
        }

        doc.add(table);

    }
}
