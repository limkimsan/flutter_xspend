package com.example.flutter_xspend;

import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.Context;
import android.content.SharedPreferences;
import android.widget.RemoteViews;
import android.widget.LinearLayout;
import android.view.View;
import android.os.Bundle;
import es.antonborri.home_widget.HomeWidgetPlugin;
import java.util.Timer;
import java.util.TimerTask;

/**
 * Implementation of App Widget functionality.
 */
public class SummaryWidget extends AppWidgetProvider {

    static void updateAppWidget(Context context, AppWidgetManager appWidgetManager, int appWidgetId) {

        // CharSequence widgetText = context.getString(R.string.appwidget_text);
        // Construct the RemoteViews object
        RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.summary_widget);
        // views.setTextViewText(R.id.appwidget_text, widgetText);
        // Instruct the widget manager to update the widget
        appWidgetManager.updateAppWidget(appWidgetId, views);
    }

    static void updateWidgetData(Context context, AppWidgetManager appWidgetManager, int appWidgetId, RemoteViews views) {
        SharedPreferences prefs = context.getSharedPreferences("HomeWidgetPreferences", Context.MODE_PRIVATE);
        String income = prefs.getString("income", "0.00");
        String expense = prefs.getString("expense", "0.00");
        String total = prefs.getString("total", "0.00");
        views.setTextViewText(R.id.income_text, income);
        views.setTextViewText(R.id.expense_text, expense);
        views.setTextViewText(R.id.summarywidget_total_amount_vertical, total);
        views.setTextViewText(R.id.summarywidget_total_amount_horizontal, total);
        appWidgetManager.updateAppWidget(appWidgetId, views);
    }

    @Override
    public void onUpdate(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds) {
        // There may be multiple widgets active, so update all of them
        SharedPreferences prefs = context.getSharedPreferences("HomeWidgetPreferences", Context.MODE_PRIVATE);
        boolean isFirstTime = prefs.getBoolean("is_first_time", false);

        RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.summary_widget);
        for (int appWidgetId : appWidgetIds) {
            if (isFirstTime) {
                views.setViewVisibility(R.id.summarywidget_total_amount_horizontal, View.GONE);
                SharedPreferences.Editor editor = prefs.edit();
                editor.putBoolean("is_first_time", false);
                editor.apply();
            }
            updateWidgetData(context, appWidgetManager, appWidgetId, views);
        }
    }

    @Override
    public void onEnabled(Context context) {
        super.onEnabled(context);
        SharedPreferences prefs = context.getSharedPreferences("HomeWidgetPreferences", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = prefs.edit();
        editor.putBoolean("is_first_time", true);
        editor.apply();
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
            views.setViewVisibility(R.id.summarywidget_total_amount_vertical, View.GONE);
            views.setViewVisibility(R.id.summarywidget_total_amount_horizontal, View.VISIBLE);
        }
        else {
            views.setViewVisibility(R.id.summarywidget_total_amount_horizontal, View.GONE);
            views.setViewVisibility(R.id.summarywidget_total_amount_vertical, View.VISIBLE);
        }
        updateWidgetData(context, appWidgetManager, appWidgetId, views);
    }
}