package com.example.flutter_xspend;

import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.Context;
import android.widget.RemoteViews;
import android.widget.LinearLayout;
import android.view.View;
import android.os.Bundle;

/**
 * Implementation of App Widget functionality.
 */
public class SummaryWidget extends AppWidgetProvider {

    static void updateAppWidget(Context context, AppWidgetManager appWidgetManager, int appWidgetId) {

        CharSequence widgetText = context.getString(R.string.appwidget_text);
        // Construct the RemoteViews object
        RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.summary_widget);
        // views.setTextViewText(R.id.appwidget_text, widgetText);
        // Instruct the widget manager to update the widget
        appWidgetManager.updateAppWidget(appWidgetId, views);
    }

    @Override
    public void onUpdate(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds) {
        // There may be multiple widgets active, so update all of them
        for (int appWidgetId : appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId);
        }
    }

    // @Override
    public void onEnabled(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds) {
        // Enter relevant functionality for when the first widget is created

        RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.summary_widget);
        views.setViewVisibility(R.id.summarywidget_total_horizontal_container, View.GONE);
        for (int appWidgetId : appWidgetIds) {
            appWidgetManager.updateAppWidget(appWidgetId, views);
        }
    }

    @Override
    public void onDisabled(Context context) {
        // Enter relevant functionality for when the last widget is disabled
    }

    @Override
    public void onAppWidgetOptionsChanged(Context context, AppWidgetManager appWidgetManager, int appWidgetId, Bundle newOptions) {
        super.onAppWidgetOptionsChanged(context, appWidgetManager, appWidgetId, newOptions);

        RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.summary_widget);

        if (newOptions.getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_WIDTH) > 272) {
            views.setViewVisibility(R.id.summarywidget_total_vertical_container, View.GONE);
            views.setViewVisibility(R.id.summarywidget_total_horizontal_container, View.VISIBLE);
            appWidgetManager.updateAppWidget(appWidgetId, views);


            // AppWidgetManager appWidgetManager = AppWidgetManager.getInstance(context);
            // appWidgetManager.updateAppWidget(appWidgetId, views);
            // views.setString(R.id.summarywidget_total_amount, "android:layout_marginTop", "0dp");
            // views.setString(R.id.summaryWidget_total_amount, "android:gravity", "right");
        }
        else {
            views.setViewVisibility(R.id.summarywidget_total_horizontal_container, View.GONE);
            views.setViewVisibility(R.id.summarywidget_total_vertical_container, View.VISIBLE);
            appWidgetManager.updateAppWidget(appWidgetId, views);
        }
    }
}